From: Alex Williamson <alex.williamson-VXdhtT5mjnY@public.gmane.org>
Subject: LEqual fix for 2.6.9?
Date: Mon, 11 Oct 2004 09:27:03 -0600
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1097508423.4794.16.camel@tdi>
References: <37F890616C995246BE76B3E6B2DBE05501E638C4@orsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <37F890616C995246BE76B3E6B2DBE05501E638C4-sBd4vmA9Se5Qxe9IK+vIArfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


   It looks like 20040816 is going to be the version in 2.6.9 unless Len
is going to try another push.  Is there any chance we can get just the
LEqual piece of 20040827 or the patch I posted in before 2.6.9?  HP
sx1000 based ia64 systems currently get a spew of these when booting
anything since 2.6.8:

ACPI-1133: *** Error: Method execution failed [\_SB_.N000.S000.IOC0.L000.SSTA] (Node e00007002884ec00), AE_AML_NO_RETURN_VALUE
ACPI-1133: *** Error: Method execution failed [\_SB_.N000.S000.IOC0.L000.SBF0._STA] (Node e00007002884e1c0), AE_AML_NO_RETURN_VALUE
ACPI-0158: *** Error: Method execution failed [\_SB_.N000.S000.IOC0.L000.SBF0._STA] (Node e00007002884e1c0), AE_AML_NO_RETURN_VALUE
ACPI-1133: *** Error: Method execution failed [\_SB_.N000.S000.IOC0.L000.SSTA] (Node e00007002884ec00), AE_AML_NO_RETURN_VALUE
ACPI-1133: *** Error: Method execution failed [\_SB_.N000.S000.IOC0.L000.SBF1._STA] (Node e00007002884e040), AE_AML_NO_RETURN_VALUE
ACPI-0158: *** Error: Method execution failed [\_SB_.N000.S000.IOC0.L000.SBF1._STA] (Node e00007002884e040), AE_AML_NO_RETURN_VALUE
ACPI-1133: *** Error: Method execution failed [\_SB_.N000.S000.IOC0.L000.SSTA] (Node e00007002884ec00), AE_AML_NO_RETURN_VALUE
...

This still feels like a regression to me.  Thanks,

	Alex

On Fri, 2004-09-03 at 10:38 -0700, Moore, Robert wrote:
> We are working to get this into the ACPI 3.0 specification.
> 
> The code has been released in ACPI CA version 20040827.  It may not have
> been released to Linux yet.
> 
> 
> 
> > -----Original Message-----
> > From: Alex Williamson
> > Sent: Friday, September 03, 2004 10:13 AM
> > To: Moore, Robert
> > Cc: acpi-devel
> > Subject: Make LEqual less strict
> > 
> > Hi Bob,
> > 
> >    We discussed making LEqual less strict about requiring both
> operands
> > to be identical types a couple weeks ago.  It sounded like the plan
> was
> > to convert the second operand to match the first for the case where
> > they're not equal.  I haven't seen a code change for this yet, so I'll
> > toss this out in case it helps someone else.  It works for me, and
> gets
> > rid of all the errors my box was spewing with the new CA.  Thanks,
> > 
> > 	Alex
> > 
> > --
> > Signed-off-by: Alex Williamson <alex.williamson-VXdhtT5mjnY@public.gmane.org>
> > 
> > ===== drivers/acpi/executer/exoparg2.c 1.25 vs edited =====
> > --- 1.25/drivers/acpi/executer/exoparg2.c	2004-06-21 18:35:22
> -06:00
> > +++ edited/drivers/acpi/executer/exoparg2.c	2004-09-03 10:35:06
> -06:00
> > @@ -573,17 +573,48 @@
> >  	 * Execute the Opcode
> >  	 */
> >  	if (walk_state->op_info->flags & AML_LOGICAL) /* logical_op
> > (Operand0, Operand1) */ {
> > -		/* Both operands must be of the same type */
> > +		union acpi_operand_object *temp_desc = NULL;
> > 
> > -		if (ACPI_GET_OBJECT_TYPE (operand[0]) !=
> > -			ACPI_GET_OBJECT_TYPE (operand[1])) {
> > -			status = AE_AML_OPERAND_TYPE;
> > -			goto cleanup;
> > +		/*
> > +		 * Convert the second operand if necessary.  The first
> > +		 * operand determines the type of the second operand.
> > +		 */
> > +		switch (ACPI_GET_OBJECT_TYPE (operand[0])) {
> > +		case ACPI_TYPE_INTEGER:
> > +			status = acpi_ex_convert_to_integer (operand[1],
> > +			                                     &temp_desc,
> > +
> walk_state);
> > +			break;
> > +
> > +		case ACPI_TYPE_STRING:
> > +			status = acpi_ex_convert_to_string (operand[1],
> > +			                                    &temp_desc,
> 16,
> > +
> ACPI_UINT32_MAX,
> > +							    walk_state);
> > +			break;
> > +
> > +		case ACPI_TYPE_BUFFER:
> > +			status = acpi_ex_convert_to_buffer (operand[1],
> > +			                                    &temp_desc,
> > +							    walk_state);
> > +			break;
> > +
> > +		default:
> > +			ACPI_REPORT_ERROR (("logical_op - invalid obj
> type:
> > %X\n",
> > +					ACPI_GET_OBJECT_TYPE
> (operand[0])));
> > +			status = AE_AML_INTERNAL;
> >  		}
> > 
> > +		if (ACPI_FAILURE (status))
> > +			goto cleanup;
> > +
> >  		logical_result = acpi_ex_do_logical_op
> (walk_state->opcode,
> >  				 operand[0],
> > -				 operand[1]);
> > +				 temp_desc);
> > +
> > +		if (temp_desc != operand[1])
> > +			acpi_ut_remove_reference(temp_desc);
> > +
> >  		goto store_logical_result;
> >  	}
> > 
> > 
> 
-- 
Alex Williamson                             HP Linux & Open Source Lab



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
