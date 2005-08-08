From: "Paulo Vitor Magacho da Silva" <pvmagacho78-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Subject: RE: EC Confusion
Date: Mon, 08 Aug 2005 14:21:30 -0300
Message-ID: <BAY12-F101F7B80C1491D486B2A9DA8B80@phx.gbl>
References: <3ACA40606221794F80A5670F0AF15F84041AC1F9@pdsmsx403>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3ACA40606221794F80A5670F0AF15F84041AC1F9@pdsmsx403>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

I all I got was :
**** Context Switch from TID EEC to TID 7 ****
acpi_bus-0306 [0007] [17] acpi_bus_generate_even: ----Entry
acpi_bus-0330 [0007] [17] acpi_bus_generate_even: ----Exit- 0000000000000000
**** Context Switch from TID 7 to TID EEC ****
acpi_bus-0376 [0EEC] [14] acpi_bus_receive_event: ----Exit- 0000000000000000
acpi_bus-0343 [0EEC] [14] acpi_bus_receive_event: ----Entry


Thanks,
Paulo

>From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>To: "Paulo Vitor Magacho da Silva" <pvmagacho78-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
>CC: <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
>Subject: RE: [ACPI] EC Confusion
>Date: Mon, 8 Aug 2005 21:29:09 +0800
>
>Hi,
>Could you try acpi_dbg_layer=0x10000  acpi_dbg_level =0xFFFFFFFF,
>If you press sleep button, you should see
>"Received DEVICE WAKE notification for device [SLPB]"
>
>If yes, I don't think sleep button was confused by EC.
>
>Thanks
>Luming
>

_________________________________________________________________
MSN Messenger: converse online com seus amigos .  
http://messenger.msn.com.br



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
