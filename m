From: Nick Lidakis <nlidakis-H+0wwilmMs3R7s880joybQ@public.gmane.org>
Subject: Re: S3 on Intel Desktop Board D865GBF
Date: Tue, 25 May 2004 11:26:45 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <40B373C5.4030400@verizon.net>
References: <1085272779.7511.11.camel@300mlinux>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1085272779.7511.11.camel-Yau0ytKvSx2eZLLa646FqQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andrew Barr <barr.156-ZbGKxL/pcrQ@public.gmane.org>, Acpi-Devel List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Andrew Barr wrote:

>I'm trying to get S3 to work on an Intel D865GBF Desktop Board (Intel
>865G chipset) running a 2.6.6 vanilla kernel. Right now, the computer
>powers up after a resume and some devices initialize (CD drives), but
>the display remains off. Adding acpi_sleep=s3_mode to the command line
>does nothing (visibly) and acpi_sleep=s3_bios causes a Video BIOS
>identification screen to be displayed. The keyboard and mouse do not
>work, and pinging the machine's wireless card fails as well.
>
>When the machine resumes, the power LED is off, and pressing the reset
>switch fails to bring up the BIOS "silent boot" screen. Only by forcibly
>shutting off the machine (hold down the power button, pull the plug) and
>turning back on can I get it to boot.
>
>What needs done to get S3 working on a system like this?
>
>  
>
I tried to get S3 suspend working on a similar motherboard: an Intel 
D975PBZ. There is a thread about it on the list.

The gist of the (very helpful) replies were:

Disable the SMP (if your using Hyperthreading that is) and preempt 
kernel options. Make sure you have the ACPI option for suspend in the 
the bios set to S3. The default is S1.
I am using a ATI Radeon 9700 pro and was told that suspend might not be 
possible with this card, that using a Radeon 7000 card might increase my 
chances of success.

I was thinking of picking up a Radeon 7000 (haven't seen any with DVI 
out) to see if I can get S3 to work that way, but haven't had the time. 
I might try building a spare machine with one of the new Pentium M 
desktop boards that are just being released, seeing that I might have 
beter luck getting S3 to work with a laptop chipset. Ther other plus 
would be the CPU can be passivley cooled, resulting in a truly silent 
machine.

Oh, how I envy those Mac heads and their sleep function.

Good luck, let me know if you have any luck with that board.


Nick

 


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
