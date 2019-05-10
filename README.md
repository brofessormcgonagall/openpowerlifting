# openpowerlifting
A MATLAB script to analyze data from the OpenPowerlifting Project using Machine Learning techniques.

The data itself is roughly 250MB unzipped, and even the compressed file is ~32MB, so I can't upload that here.  So, if you plan on playing with this code, make sure you download the data from https://www.openpowerlifting.org/data and take note of the data you accessed the data, as results will vary slightly.

Note that the user must specify the name of the CSV file containing the data (I named my file with the access date, since the data is constantly updated).  The user also specifies the sex, equipment type, event, and division to be considered.  Weight class distinctions are modern IPF classes, to ensure like weights are compared. (Of course, this neglects the "peak" effect we see at weight class boundaries, but that is a problem for another day).

I hope people get a kick out of this at least, and maybe it can spark some interest from more serious coders to take a look at what ML can do to this data.  Enjoy, and thanks for checking out my project!
