From: hugo hallqvist <hugha495-oe7qfRrRQfdIcsJQ0EH25Q@public.gmane.org>
Subject: RE: new n800v dsdt successfully disassembled, patched and
	install	ed (WAS: disasm/compile doesn't work)
Date: 16 Oct 2002 00:47:48 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1034722068.388.6.camel@i70>
References: <B9ECACBD6885D5119ADC00508B68C1EA0D19B84E@orsmsx107.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <B9ECACBD6885D5119ADC00508B68C1EA0D19B84E-LkGsggTGxVmSsB6bSF6DdVDQ4js95KgL@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: 'Bob Lees' <bob-l+PWtdWbHAsG2Il/BtU0GPXRex20P6io@public.gmane.org>, Mark Pritchard <mark.pritchard-acpi-3o+aUUpM7Xj0CCvOHzKKcA@public.gmane.org>, acpi mail list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

tis 2002-10-15 klockan 23.58 skrev Moore, Robert:
> 
> We have seen the AE_ALREADY_EXISTS error before, but we have never been able
> to track it down.  It will probably require a full debug trace of the ACPI
> initialization.
> 
> The AE_AML_BUFFER_LIMIT is interesting.  It sounds like a Field is being
> defined past the end of the buffer, but I would be interested in taking a
> look at it.
> 
> Please send your AML/ASL and I'll see what I can find.
> 
> Thanks,
> Bob Moore

Hi guys,

I think I have a fix for this.

If you have  a method called C04C at about line 495-500,
then add a little before you make a buffer out of it.
At least that is my interpretation of the code, 
with this fix I don't get the AML_BUFFER_LIMIT error anymore, 
however this may not be the right way<tm> to do it..?

//line 494
// addition
            Method (C04C, 0, NotSerialized)
            {
                Acquire (C042, 0xFFFF)
                Multiply (C043, 0x1A, Local1)
                Add (SizeOf (C046), Local1, Local2)
                Add(Local2, 0xB0, Local7)  //add a little to the size
                Store (Buffer (Local7) {}, Local0)  //then make a buffer
//                Store (Buffer (Local2) {}, Local0)    // original code
                Store (0x00, Local1)
                Store (0x00, Local2)

Also, would it be possible to get any of you guys final dsdt's for the
compaq evo n800v? I have messed mine up, have problems with Alias links 
and also the thermal zones/fans. :-(

Thanks in advance,

//Hugo


-------------------------------------------------------
This sf.net email is sponsored by: viaVerio will pay you up to
$1,000 for every account that you consolidate with us.
http://ad.doubleclick.net/clk;4749864;7604308;v?
http://www.viaverio.com/consolidator/osdn.cfm
