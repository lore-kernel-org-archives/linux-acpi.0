From: "Paul V. Gratz" <pgratz@gratz1.com>
Subject: ACPI errors when pressing brightness hot keys on new HP Spectre 13 x2
 laptop/tablet combo
Date: Fri, 20 Dec 2013 10:30:35 -0600
Message-ID: <CAEbBMJJSnrKYgJy83AFtkVo9oFTe31QJGmFsO4Mc=0sqq+tK4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vc0-f177.google.com ([209.85.220.177]:54793 "EHLO
	mail-vc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754040Ab3LTQa4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Dec 2013 11:30:56 -0500
Received: by mail-vc0-f177.google.com with SMTP id hq11so1536772vcb.36
        for <linux-acpi@vger.kernel.org>; Fri, 20 Dec 2013 08:30:55 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

I hope I'm not stepping on toes to post directly to this mailing list,
the hp-wmi author suggested I email about this issue here.

The issue is that on my new laptop when I press the brightness hot
keys I get the following ACPI errors (and nothing else happens):

[ 3324.617378]  ACPI Error: [^^^PEG0.PEGP.DD02] Namespace lookup
failure, AE_NOT_FOUND (20130725/psargs-359)
[ 3324.617386] ACPI Error: Method parse/execution failed
[\_SB_.PCI0.LPCB.EC0_._Q1D] (Node ffff8801592fc730), AE_NOT_FOUND
(20130725/psparse-536)
[ 3325.604163] ACPI Error: [^^^PEG0.PEGP.DD02] Namespace lookup
failure, AE_NOT_FOUND (20130725/psargs-359)
[ 3325.604171] ACPI Error: Method parse/execution failed
[\_SB_.PCI0.LPCB.EC0_._Q1C] (Node ffff8801592fc708), AE_NOT_FOUND
(20130725/psparse-536)

I'd love to get these keys working if possible.  I am on the a 3.12.5
kernel with the latest version of my bios installed.  These keys do
work properly in windows.

Thanks!
Paul


On Fri, Dec 20, 2013 at 9:20 AM, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
>
> On Thu, Dec 19, 2013 at 01:57:44PM -0600, Paul V. Gratz wrote:
> > Dear Matthew,
> > I understand you are the maintainer of hp-wmi.c in the linux kernel.  I
> > hope you don't mind me contacting you directly.  I worked with a couple
> > people on the Ubuntuforums first and they suggested I elevate this at a
> > kernel issue.   The issue is that I have a new HP Spectre 13 x2
> > laptop/tablet hybrid and while the hp-wmi module does seem to catch most of
> > my hot keys, the brightness keys are ignored.  When I hit them I see the
> > following in my dmesg:
>
> Brightness keys should be handled by the ACPI video driver rather than
> hp-wmi.
>
> > [ 3324.617378] ACPI Error: [^^^PEG0.PEGP.DD02] Namespace lookup failure,
> > AE_NOT_FOUND (20130725/psargs-359)
> > [ 3324.617386] ACPI Error: Method parse/execution failed
> > [\_SB_.PCI0.LPCB.EC0_._Q1D] (Node ffff8801592fc730), AE_NOT_FOUND
> > (20130725/psparse-536)
> > [ 3325.604163] ACPI Error: [^^^PEG0.PEGP.DD02] Namespace lookup failure,
> > AE_NOT_FOUND (20130725/psargs-359)
> > [ 3325.604171] ACPI Error: Method parse/execution failed
> > [\_SB_.PCI0.LPCB.EC0_._Q1C] (Node ffff8801592fc708), AE_NOT_FOUND
> > (20130725/psparse-536)
>
> Yeah, something's going wrong here - your ACPI tables are referencing
> a method that doesn't appear to exist. You'll probably need to take this
> to linux-acpi@vger.kernel.org.
>
> --
> Matthew Garrett | mjg59@srcf.ucam.org




--
-----------------------------------------
Paul V. Gratz
Assistant Professor
ECE Dept, Texas A&M University
Office: 333M WERC
Phone: 979-488-4551
http://cesg.tamu.edu/faculty/paul-gratz/



--
-----------------------------------------
Paul V. Gratz
Assistant Professor
ECE Dept, Texas A&M University
Office: 333M WERC
Phone: 979-488-4551
http://cesg.tamu.edu/faculty/paul-gratz/
