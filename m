From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: S3 test tool (was : Re: Bizarre oops after suspend to RAM
	(was: Re: [ACPI] Resume from Suspend to RAM))
Date: Tue, 14 Jun 2005 09:47:21 +0100
Message-ID: <1118738841.6648.514.camel@tyrosine>
References: <200506061531.41132.stefandoesinger@gmx.at>
	 <1118125410.3828.12.camel@linux-hp.sh.intel.com>
	 <87ll5diemh.fsf@www.codersbase.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261325AbVFNIrs@vger.kernel.org>
In-Reply-To: <87ll5diemh.fsf@www.codersbase.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dagit@codersbase.com
Cc: Shaohua Li <shaohua.li@intel.com>, stefandoesinger@gmx.at, acpi-dev <acpi-devel@lists.sourceforge.net>, lkml <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-acpi@vger.kernel.org

On Tue, 2005-06-14 at 00:25 -0700, dagit@codersbase.com wrote:

> The reason for (2) is because if I remove the pushl;popl, boot into
> windows suspend/resume, and immeditaly boot into linux then the
> suspend/resume works.  I have screen blanking issues, but I can type
> blindly and the commands all work just fine (I can startx for
> example).

Can you do a lspci -vxxx

a) After a cold boot into linux
b) After a warm boot into linux from Windows

and see if there's any difference between the two?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
