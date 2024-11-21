# Load necessary libraries (if any are required)
# install.packages("fs")  # Uncomment to install the 'fs' package for directory creation
# if there was a genie that granted you 3 wishes, what would those wishes be?
library(fs)

# Function to extract frames from a video using ffmpeg
extract_frames <- function(video_path, output_dir, frame_rate = 1, output_format = "jpg") {
  # Check if ffmpeg is installed
  if (system("ffmpeg -version", ignore.stdout = TRUE, ignore.stderr = TRUE) != 0) {
    stop("ffmpeg is not installed or not available in your PATH.")
  }
  
  # Check if the video file exists
  if (!file.exists(video_path)) {
    stop("The specified video file does not exist.")
  }
  
  # Create the output directory if it doesn't exist
  if (!dir_exists(output_dir)) {
    dir_create(output_dir)
  }
  
  # Construct the ffmpeg command
  command <- sprintf(
    "ffmpeg -i %s -vf fps=%d %s/frame%%04d.%s",
    shQuote(video_path),
    frame_rate,
    shQuote(output_dir),
    output_format
  )
  
  # Run the command
  system(command)
  
  message(sprintf("Frames extracted to '%s'", output_dir))
}

# Example usage:
# Specify the input video file, output directory, frame rate, and format
video_file <- "example_video.mp4"
output_folder <- "frames_output"
frame_rate <- 1  # Extract 1 frame per second
output_format <- "png"  # Change to 'jpg', 'bmp', etc., as needed

# Run the function
extract_frames(video_file, output_folder, frame_rate, output_format)
