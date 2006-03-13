From: Greg KH <gregkh@suse.de>
Subject: Re: 2.6.16-rc6: known regressions
Date: Mon, 13 Mar 2006 12:12:19 +0000
Message-ID: <20060313121219.GB13652@suse.de>
References: <Pine.LNX.4.64.0603111551330.18022@g5.osdl.org> <20060313200544.GG13973@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932415AbWCMUPm@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20060313200544.GG13973@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Avuton Olrich <avuton@gmail.com>, xfs-masters@oss.sgi.com, linux-xfs@oss.sgi.com, Dave Jones <davej@redhat.com>, len.brown@intel.com, linux-acpi@vger.kernel.org, norsk5@xmission.com, dsp@llnl.gov, bluesmoke-devel@lists.sourceforge.net, linux-usb-devel@lists.sourceforge.net, pete.chapman@exgate.tek.com, Olaf Hering <olh@suse.de>, paulus@samba.org, anton@samba.org, linuxppc64-dev@ozlabs.org, Tom Seeley <redhat@tomseeley.co.uk>, Jiri Slaby <jirislaby@gmail.com>, laredo@gnu.org, v4l-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com
List-Id: linux-acpi@vger.kernel.org

On Mon, Mar 13, 2006 at 09:05:44PM +0100, Adrian Bunk wrote:
> Subject    : Stradis driver udev brekage
> References : http://bugzilla.kernel.org/show_bug.cgi?id=6170
>              https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=181063
>              http://lkml.org/lkml/2006/2/18/204
> Submitter  : Tom Seeley <redhat@tomseeley.co.uk>
>              Dave Jones <davej@redhat.com>
> Handled-By : Jiri Slaby <jirislaby@gmail.com>
> Status     : unknown

Jiri, why did you create a kernel.org bugzilla bug with almost no
information in it?

Anyway, this is the first I've heard of this, more information is
needed to help track it down.  How about the contents of /sys/class/dvb/ ?

thanks,

greg k-h
