From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Req: debug dsdt of Toshiba M30
Date: Mon, 28 Feb 2005 19:29:10 +0100
Message-ID: <20050228182910.GL12182@poupinou.org>
References: <4220D0CF.3090705@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4220D0CF.3090705-hi6Y0CQ0nG0@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Tommy Ch." <tommy-c-hi6Y0CQ0nG0@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sat, Feb 26, 2005 at 08:41:03PM +0100, Tommy Ch. wrote:
> Hi!
> 
> I'm new to the list and I would like to request your help. I'm glad that 
> some time ago I got setting the brightness working with the help of .. 
> erm, I think it was Bruno Ducrot. I send him my DSDT or something. Since 
> this time I learned a lot about that stuff and now need some help in 
> debugging the DSDT of my Toshiba M30 Laptop. Trying to compile it with 
> the intel compiler I get the following errors:

Well, I don't remember if that's me.
But I have an acpidmp for a toshiba M30-404.
> 
> Do you have any ideas? Is it worth correcting these errors? Can you tell 
> if it will have any advantages? This is the context of one of the error 
> lines:
> 
> Method (_PS0, 0, Serialized)
>  {
>    Store (0x00, \_SB.MEM.CRTS)
>    If (LEqual (\_SB.MEM.RPPC, 0x01))
>      {
>       Notify (\_PR.CPU0, 0x80)
>       Store (0x00, \_SB.MEM.RPPC)
>      }
> }

After doing something like this:

ducrot@neptune:~/acpi_hack/toshiba-M30-404$ ../pmtools/acpidmp/acpixtract SSDT > ssdt < acpidmp
ducrot@neptune:~/acpi_hack/toshiba-M30-404$ iasl-20041203 -d ssdt

and the resulting ssdt.dsl will contains the processor object.

So all you have to do is to add something like that:
External (\_PR.CPU0)
onto the dsdt.dsl in order to get rid of those errors.

A corresponding diff is:

--- dsdt.dsl	2005/02/28 18:21:07	1.1
+++ dsdt.dsl	2005/02/28 18:21:27
@@ -6,6 +6,7 @@
  */
 DefinitionBlock ("DSDT.aml", "DSDT", 1, "TOSHIB", "A0007   ", 537069574)
 {
+    External (\_PR.CPU0)
     OperationRegion (SMIP, SystemIO, 0xB2, 0x01)
     Field (SMIP, ByteAcc, NoLock, Preserve)
     {


> And perhaps: can anybody tell me why it isn't possible to switch CRT or 
> S-VIDEO on with the toshiba acpi driver? Is it possible to see this from 
> the disassembly?

I dont know for the toshiba acpi driver.  But there is for sure support
for the acpi_video driver in this dsdt.

It may be fine to test if by chance acpi_video work.

Cheers,

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
