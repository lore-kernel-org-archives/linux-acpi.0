From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: New SmartBattery DSDT-based controller
Date: Mon, 31 Jan 2005 16:12:35 +0100
Message-ID: <20050131151235.GB1145@poupinou.org>
References: <41FBDDE2.1050403@bartol.udel.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <41FBDDE2.1050403-OBnUx95tOyn10jlvfTC4gA@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Rich Townsend <rhdt-OBnUx95tOyn10jlvfTC4gA@public.gmane.org>
Cc: Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sat, Jan 29, 2005 at 02:02:58PM -0500, Rich Townsend wrote:
> Dear All,
...

> To get the ball rolling, I have on my website the two modified DSDTs:
> 
> Acer TravelMate 4502lmi:
> http://shayol.bartol.udel.edu/~rhdt/download/tm4502lmi-sbs-cm.aml
> (this is my own 1.6GHz Centrino machine, I've confirmed this works)
> 
> Acer TravelMate 4001wlmi:
> http://shayol.bartol.udel.edu/~rhdt/download/tm4001wlmi-sbs-cm.aml
> (this is based on the *fixed* DSDT posted on Johan Vromans' web page, 
> for his 1.5Ghz Centrino machine; I've not been able to test it, but I 
> expect it to work).
> 

You should provide at least diffs or else be prepared for rewrite some.
THere is those stuff in those ASLs:

ducrot@neptune:~/acpi_hack$ grep SystemMemo tm4502lmi-sbs-cm.asl
    OperationRegion (MNVS, SystemMemory, 0x1DEECE59, 0x60)
                OperationRegion (VNVS, SystemMemory, 0x1DEECEB9, 0x00010004)
                OperationRegion (SMI1, SystemMemory, 0x1DEFCEBD, 0x00000090)

That means that if someone owns a tm4502lmi, but different amount of
RAM, then all of those ORs will likely fail.

I don't see the point of making this if this is only for
smartbatt.  Do you have to override the DSDT for something else
(and then, well, why not)?

Cheers,

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
