From: Emma Jane Hogbin <emmajane-MHIYrZpDPrNWk0Htik3J/w@public.gmane.org>
Subject: Re: 2.6 won't poweroff
Date: Thu, 27 May 2004 12:04:36 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040527160436.GE2810@smeagol>
References: <20040525044514.GC2217@smeagol> <Pine.LNX.4.60.0405251112580.1337@frog.athome> <1085638695.17686.64.camel@dhcppc4> <Pine.LNX.4.60.0405271714330.4143@frog.athome>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.60.0405271714330.4143-KnfdeQs3A3X/9pzu0YdTqQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, May 27, 2004 at 05:22:22PM +0200, liste-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org wrote:
> My problem with Emma is, that I have the same TM634 and no problem with 
> vanilla 2.6.6 kernel to power-off. There was something around 2.6.4 IIRC, 
> but it was worked-around by not compiling in APIC-support. But I do not 
> know, if this issue still persists.

I was thinking some more about this...I read somewhere that the 2.4 kernel 
uses /proc events and the 2.6 kernel uses /sys events and that if you're using 
old scripts with a new kernel "halt" won't work because it's trying to turn off 
/proc events. Does that make sense? How would I know what my system is
doing? (Debian unstable.)

> Emma, does your TM634 has the latest BIOS from Acer, i.e. R01-C0O?

I'm not sure how I'd check. :/

thanks for all of your ideas about my problem! I appreciate it. :)

emma

-- 
Emma Jane Hogbin
[[ 416 417 2868 ][ www.xtrinsic.com ]]


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
