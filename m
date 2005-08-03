From: "Paulo Vitor Magacho da Silva" <pvmagacho78-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Subject: Re: EC Confusion
Date: Wed, 03 Aug 2005 18:07:37 -0300
Message-ID: <BAY12-F16C2CEDB72F72ED1D1A1A0A8C50@phx.gbl>
References: <200508032243.59524.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200508032243.59524.rjw-KKrjLPT3xs0@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello,

   the kernel command line: ro root=LABEL=/ rhgb quiet acpi=on 
acpi_dbg_layer=0x14000F acpi_dbg_level=0x1F ec_polling
   Is this correct ?
   I still have the same problem. Here is the dmesg important part. I have 
to hit the sleep button 8 time before it works :
acpi_ec-0810 [08] acpi_ec_gpe_query     : Evaluating _Q20
acpi_ec-0810 [09] acpi_ec_gpe_query     : Evaluating _Q20
acpi_ec-0810 [10] acpi_ec_gpe_query     : Evaluating _Q20
acpi_ec-0810 [11] acpi_ec_gpe_query     : Evaluating _Q20
acpi_ec-0810 [12] acpi_ec_gpe_query     : Evaluating _Q20
acpi_ec-0810 [13] acpi_ec_gpe_query     : Evaluating _Q20
acpi_ec-0810 [14] acpi_ec_gpe_query     : Evaluating _Q20
acpi_ec-0810 [15] acpi_ec_gpe_query     : Evaluating _Q0D
  evmisc-0152 [24] ev_queue_notify_reques: Dispatching Notify(80) on node 
dff217e8
  evmisc-0161 [24] ev_queue_notify_reques: Notify value: 0x80 **Device 
Specific**

  As I said, kernels 2.6.12-rc2-mm2 and kernel 2.6.7 work for me.

Thanks,
Paulo

>From: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
>To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>CC: "Paulo Vitor Magacho da Silva" 
><pvmagacho78-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>,luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
>Subject: Re: [ACPI] EC Confusion
>Date: Wed, 3 Aug 2005 22:43:59 +0200
>
>On Wednesday, 3 of August 2005 22:05, Paulo Vitor Magacho da Silva wrote:
> > Hi,
> >
> > I've tryed and had the same problem. How do I enable ec_polling ? During
> > boot with ec_polling=on ?
>
>Just ec_polling,
>
>Rafael
>
>
>--
>- Would you tell me, please, which way I ought to go from here?
>- That depends a good deal on where you want to get to.
>		-- Lewis Carroll "Alice's Adventures in Wonderland"
>
>
>-------------------------------------------------------
>SF.Net email is Sponsored by the Better Software Conference & EXPO
>September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
>Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
>Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
>_______________________________________________
>Acpi-devel mailing list
>Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>https://lists.sourceforge.net/lists/listinfo/acpi-devel

_________________________________________________________________
MSN Messenger: converse online com seus amigos .  
http://messenger.msn.com.br



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
