From: Tugrul Galatali <tugrul-aJBGfH1wNSRWk0Htik3J/w@public.gmane.org>
Subject: Re: Linux 2.6-pre1 Does not boot on ASUS L3800C: lock up in acpi
	while "Executing all Devices _STA and_INIT methods"
Date: 14 Jul 2003 14:38:28 -0400
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <1058207908.704.5.camel@duality.galatali.com>
References: <3F12AF06.6080004@free.fr>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <3F12AF06.6080004-GANU6spQydw@public.gmane.org>
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, 2003-07-14 at 09:24, Eric Valette wrote:
> I happily run 2.4.21-pre5 with ACPI enabled and everything works just 
> fine. I tried today 2.6-pre1 with exactly the same hardware 
> configuration as the 2.4 one and the laptop does not boot. It hangs 
> while dispaying : "Executing all Devices _STA and_INIT methods" 
> allthough it has already printed several '.'

	I get that error plus the message I've been getting from >2.5.69
kernels when booting with ACPI on my Compaq W8000. dmesg/lspci/configs
at 

	http://acm.cs.nyu.edu/~tugrul/acpi/

	The 2.6.0-test1 error is pretty big for hand transcription, but I'll
try setting up serial console if requested.

	Tugrul Galatali
