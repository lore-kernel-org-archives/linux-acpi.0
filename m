From: Matt Domsch <Matt_Domsch@dell.com>
Subject: Re: [PATCH 2.6.18-mm2] acpi: add backlight support to the sony_acpi driver
Date: Sun, 1 Oct 2006 19:48:24 -0500
Message-ID: <20061002004824.GB18707@lists.us.dell.com>
References: <20060930190810.30b8737f.alessandro.guido@gmail.com> <20061001171912.b7aac1d8.akpm@osdl.org> <20061002003908.GA18707@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932548AbWJBAsW@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20061002003908.GA18707@lists.us.dell.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: Alessandro Guido <alessandro.guido@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, len.brown@intel.com, jengelh@linux01.gwdg.de, gelma@gelma.net, ismail@pardus.org.tr
List-Id: linux-acpi@vger.kernel.org

On Sun, Oct 01, 2006 at 07:39:08PM -0500, Matt Domsch wrote:
> On Sun, Oct 01, 2006 at 05:19:12PM -0700, Andrew Morton wrote:
> > umm, OK, but now how do I adjust my screen brightness? ;)
> > 
> > I assume that cute userspace applications for controlling backlight
> > brightness via the generic backlight driver either exist or are in
> > progress?  What is the status of that?
> 
> For Dell laptops, the dellLcdBrightness app is included in the
> libsmbios-bin package (http://linux.dell.com/libsmbios/main/ and
> http://linux.dell.com/libsmbios/main/yum.html for the yum repo).  It's
> entirely userspace.

Which is to say, if a system-agnostic userspace app exists, please
advise, as we'd like to incorporate dellLcdBrightness functionality
into it.

Thanks,
Matt

-- 
Matt Domsch
Software Architect
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
