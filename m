From: Faye Pearson <faye-6JSjyQ0Qj1ReoWH0uzbU5w@public.gmane.org>
Subject: Re: Re: odd irq routing errors?
Date: Fri, 14 Mar 2003 10:30:49 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030314103049.GB19277@clara.net>
References: <20030313221321.GA21296@bittwiddlers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20030313221321.GA21296-bmWjYudjZeGERhycZ4x6Ig@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Matthew Harrell <mharrell-dated-1048025602.5b63c9-bmWjYudjZeGERhycZ4x6Ig@public.gmane.org>
Cc: ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Matthew Harrell [lists-sender-12e533-bmWjYudjZeGERhycZ4x6Ig@public.gmane.org] wrote:
> : Faye Pearson writes:
> : > PCI: No IRQ known for interrupt pin A of device 00:1f.1 - using IRQ 255

> So is this problem listed below the same as the one I'm having on my laptop?
> I cannot boot any 2.5.6? kernels with acpi turned on since once acpid starts
> the laptop slows down horrendously, many programs seg fault or the scripts
> give bizarre results, and the ide controller spits out numerous messages.  Is
> there anything I can do to fix this problem?  

The message is (mis)informational rather than destructive for me.

Try removing acpid from your startup scripts before booting into 2.5.6x
then check your /proc/interrupts and see if there are a large number
being generated quickly.
This could cause laptop slowdown and perhaps overheating which can
introduce instability.  It's a known problem that I've seen
mentioned on the list.  I expect that the developers will need much more
information from you if they are to help.


Faye

-- 
Faye Pearson,
Covert Development
ClaraNET Ltd.       Tel 020 7903 3000

  The good oxymoron, to define it by a self-illustration, must be a
  planned inadvertency. -Wilson Follett


-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
