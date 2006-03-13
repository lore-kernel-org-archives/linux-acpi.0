From: Johannes Stezenbach <js@linuxtv.org>
Subject: Re: [v4l-dvb-maintainer] Re: 2.6.16-rc6: known regressions
Date: Mon, 13 Mar 2006 22:22:15 +0100
Message-ID: <20060313212215.GA6041@linuxtv.org>
References: <Pine.LNX.4.64.0603111551330.18022@g5.osdl.org> <20060313200544.GG13973@stusta.de> <20060313121219.GB13652@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from allen.werkleitz.de ([80.190.251.108]:21942 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S932459AbWCMVYC
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 13 Mar 2006 16:24:02 -0500
Content-Disposition: inline
In-Reply-To: <20060313121219.GB13652@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Greg KH <gregkh@suse.de>
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>, video4linux-list@redhat.com, norsk5@xmission.com, Jiri Slaby <jirislaby@gmail.com>, paulus@samba.org, linux-usb-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org, linuxppc64-dev@ozlabs.org, len.brown@intel.com, xfs-masters@oss.sgi.com, Linus Torvalds <torvalds@osdl.org>, anton@samba.org, laredo@gnu.org, Dave Jones <davej@redhat.com>, v4l-dvb-maintainer@linuxtv.org, dsp@llnl.gov, Avuton Olrich <avuton@gmail.com>, Tom Seeley <redhat@tomseeley.co.uk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-xfs@oss.sgi.com, pete.chapman@exgate.tek.com, Olaf Hering <olh@suse.de>, bluesmoke-devel@lists.sourceforge.net

On Mon, Mar 13, 2006 at 12:12:19PM +0000, Greg KH wrote:
> On Mon, Mar 13, 2006 at 09:05:44PM +0100, Adrian Bunk wrote:
> > Subject    : Stradis driver udev brekage
> > References : http://bugzilla.kernel.org/show_bug.cgi?id=6170
> >              https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=181063
> >              http://lkml.org/lkml/2006/2/18/204
> > Submitter  : Tom Seeley <redhat@tomseeley.co.uk>
> >              Dave Jones <davej@redhat.com>
> > Handled-By : Jiri Slaby <jirislaby@gmail.com>
> > Status     : unknown
> 
> Jiri, why did you create a kernel.org bugzilla bug with almost no
> information in it?
> 
> Anyway, this is the first I've heard of this, more information is
> needed to help track it down.  How about the contents of /sys/class/dvb/ ?

Stradis is not a DVB driver. AFAIK it uses V4L devices.

http://bugzilla.kernel.org/show_bug.cgi?id=6170 and
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=181063
seem to be two totally different bugs. First thing to check
for the Nova-T is dmesg, to see if the device was recognized
at all by the driver, so we know if it is an udev
problem or not.


BTW: http://mpeg.openprojects.net/ doesn't exist

diff --git a/MAINTAINERS b/MAINTAINERS
index 3d7d30d..922a290 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2525,7 +2525,6 @@ S:	Unsupported ?
 STRADIS MPEG-2 DECODER DRIVER
 P:	Nathan Laredo
 M:	laredo@gnu.org
-W:	http://mpeg.openprojects.net/
 W:	http://www.stradis.com/
 S:	Maintained
 

Johannes
