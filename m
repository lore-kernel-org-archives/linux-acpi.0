From: John-otv8KCb+Bkdaa/9Udqfwiw@public.gmane.org
Subject: Re: [ACPI] ACPI patches updated (20030109)
Date: Thu, 23 Jan 2003 15:42:43 +0000 (GMT)
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <E18bjUN-000FXY-00@probity.mcc.ac.uk>
References: <F760B14C9561B941B89469F59BA3A84725A119@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <F760B14C9561B941B89469F59BA3A84725A119-sBd4vmA9Se4Lll3ZsUKC9FDQ4js95KgL@public.gmane.org>
To: andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On 10 Jan, Grover, Andrew wrote:
..
> ACPI patches based upon the 20030109 label have been released.

I have a Toshiba 3000-400 laptop, which previously needed a ACPI table
bypass for it to detect the battery power levels, which I have been
doing up to 2.4.17..  

I compiled up the standard 2.4.20 and my bypass hack didn't work
anymore..

I downloaded the 20030109 patch and tried it out with 2.4.20, but the
compilation failed  in 

	arch/i386/kernel/mpparse.c

I replaced the offending function by the one from the previous 20021212
patch and the 2.4.20 kernel compiled OK.

The patched 2.4.20 kernel now detects the laptop battery correctly along
with lots of other goodies that I'd not seen before..

Bye for now, and keep up the good work..

John
