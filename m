From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: P2120 ACPI 2.5.64bk7
Date: Fri, 14 Mar 2003 23:40:31 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030314224031.GB361@elf.ucw.cz>
References: <200303130904.03589.listman@garbett.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200303130904.03589.listman-qZIqNUI/gJRAfugRpC6u6w@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Shawn P. Garbett" <listman-qZIqNUI/gJRAfugRpC6u6w@public.gmane.org>
Cc: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

> I've just gotten a P2120 because I'm a big fan of long battery life and power 
> management. I was disappointed when I discovered it was ACPI and not the 
> kinda working APM. In the long run it's probably better to have ACPI, so I'm 
> okay with this.
> 
> I installed the 2.5.64bk7 kernel to see what the current progress is. I'm 
> willing to test whatever, code and contribute if someone wants to tell me 
> what needs to be done. I have years and years of C experience and have done 
> embedded work. I just don't want to work on something that someone else is 
> already doing (wasting effort).
> 
> The S3 ACPI shutdown appears to work, but is unwakeable. At somepoint, I think 
> with the vanilla 2.5.64 kernel it worked once, I just had to hit Ctrl-Alt-F1, 
> Ctrl-Alt-F7 to get the display back.
> 
> The S4 ACPI shutdown has the "enter refrigerator" messages, followed by the 
> following:
>   stopping tasks failed (1 tasks remaining)
> Suspend failed: Not all processes stopped!
> Restarting tasks...<6> Strange, eth0 not stopped
>  done
> Then the "left refrigerator" messages follow.
> 
> So I tried "ifdown eth0; rmmod 8139too" before trying a S4 shutdown. Then 
> after the "enter refrigerator" messages, it says:
> Freeing memory, (display flickers), writing to swap, (display off). I can then 
> start it back up with a "resume=/dev/hda5" (my swap partition). I have an 
> "a0" hibernate partition, but it doesn't find or use this.

So... S4 does actually work for you?
									Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]


-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
