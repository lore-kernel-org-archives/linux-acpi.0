From: Greg Sarjeant <greg-QNIYhHqVzB9kr2E5YSwMOQ@public.gmane.org>
Subject: Re: Gateway 200x - trouble supplying ECDT table
Date: Tue, 23 Dec 2003 11:39:31 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031223113931.5ff2cddf.greg@morningdave.org>
References: <3ACA40606221794F80A5670F0AF15F8401720C4D@PDSMSX403.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8401720C4D-SRlDPOYGfgogGBtAFL8yw7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Luming,

    I am sorry that you will receive this twice. I did not send my original reply back to the mailinglist.

    Regards,
    Greg

############################################################################

Thanks, Luming.

    I applied this patch to my 2.4.23 kernel (started back from the fresh sources and applied the latest ACPI patch first). Unfortunately, I'm still getting the same sorts of messages on boot. The _REG method of the Embedded Control fails as follows:

ACPI: Embedded Controller [H_EC] (gpe 28)
evregion-0348: *** Error: Handler for [EmbeddedControl] returned AE_BAD_PARAMETER
 dswexec-0435 [30] ds_exec_end_op        : [Store]: Could not resolve operands, AE_BAD_PARAMETER
 psparse-1120: *** Error: Method execution failed [\_SB_.PCI0.LPCB.H_EC._REG] (Node df5e7ae8), AE_BAD_PARAMETER


    I then get similar errors from the battery, adapter and thermal modules, but the root always appears to be the Embedded Controller:

	ACPI: Processor [CPU0] (supports C1 C2 C3, 5 performance states, 8 throttling states)
	ACPI: Power Button (FF) [PWRF]
	ACPI: Lid Switch [LID0]
	ACPI: Sleep Button (CM) [SLPB]
	evregion-0348: *** Error: Handler for [EmbeddedControl] returned AE_BAD_PARAMETER
	 dswexec-0435 [45] ds_exec_end_op        : [Store]: Could not resolve operands, AE_BAD_PARAMETER
	 psparse-1120: *** Error: Method execution failed [\_SB_.ADP1._PSR] (Node df5f40c8), AE_BAD_PARAMETER
	 acpi_ac-0083 [36] acpi_ac_get_state     : Error reading AC Adapter state
	evregion-0348: *** Error: Handler for [EmbeddedControl] returned AE_BAD_PARAMETER
	dswexec-0435 [46] ds_exec_end_op        : [LEqual]: Could not resolve operands, AE_BAD_PARAMETER
	dswstate-0273 [48] ds_result_pop_from_bot: No result objects! State=df5fbc28
	dsutils-0525 [48] ds_create_operand     : Missing or null operand, AE_AML_NO_RETURN_VALUE
	psparse-1120: *** Error: Method execution failed [\_SB_.BAT1._STA] (Node df5f4848), AE_AML_NO_RETURN_VALUE
	evregion-0348: *** Error: Handler for [EmbeddedControl] returned AE_BAD_PARAMETER
	dswexec-0435 [46] ds_exec_end_op        : [Store]: Could not resolve operands, AE_BAD_PARAMETER
 	psparse-1120: *** Error: Method execution failed [\_TZ_.THRM._TMP] (Node df5f6f68), AE_BAD_PARAMETER
	ACPI: Fan [FAN0] (on)


    My assumption at this point is that the battery, adapter and thermal modules rely on the EC, so if I can provide an ECDT, the other errors should also go away.

    I had previously found this bug at bugzilla that deals with the same problem on the same machine:
	http://bugme.osdl.org/show_bug.cgi?id=1515

    Unfortunately, the only suggestion is to provide the ECDT manually, which is, of course, where I am stuck now. Neither of the methods that I have tried so far has worked, and I'm beginning to wonder if the DSDT is buggy enough that even providing a correct ECDT just causes errors on initialization. Is that even possible?

    I'm a little reluctant to open a new bug, since I know both the problem and the solution, Besides, it isn't really an ACPI bug, it's Gateway's issue. My only problem at this point is implementing the workaround.

    Have I missed something in applying your patch? You said that it isn't a generic solution, but I'm not quite sure what you meant by that. Do I have to modify it for my system, or do you just mean that it should allow me to circumvent the EC initialization error, but it won't help later functions that require an initialized EC?

    I have provided the entire dmesg output here in case you would find it helpful:

http://www.morningdave.org/acpi/dmesg-luming-patch

    I have also posted my DSDT here, in hope that it may shed some light on the problem:

http://www.morningdave.org/acpi/dsdt-disasm

     Thank you for your help. I'll keep digging around bugzilla to see if I can find some more pointers on supplying the ECDT manually. If you think it would be helpful for me to open a bug and post all of this information on bugzilla, I'll be happy to do it. I just don't want to give you extra bug reports for problems with known solutions (though I guess I'm cluttering your inbox with such reports now as it is).

    Thanks,
     Greg



On Tue, 23 Dec 2003 14:07:22 +0800
"Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:

> There is a patch at http://bugzilla.kernel.org/show_bug.cgi?id=1690
> trying to solve ec._INI failure due to lacking ECDT.      
> But it's not a generic solution.  Since you are faking ECDT using data
> of EC device, why not do it automatically?
> 
> --Luming                                                            
> 




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
