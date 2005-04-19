From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: Re: _CST implementation
Date: Tue, 19 Apr 2005 13:58:09 +0200
Message-ID: <4264F251.5030705@suse.de>
References: <1113598244.8367.30.camel@scotchmobil> <20050418120744.GG2298@poupinou.org> <4263EDA2.4030106@suse.de> <20050419092251.GK2298@poupinou.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070406020900000604060100"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050419092251.GK2298-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: Janosch Machowinski <scotch-cGBD8117FJM@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.
--------------070406020900000604060100
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Bruno Ducrot wrote:
> On Mon, Apr 18, 2005 at 07:25:54PM +0200, Thomas Renninger wrote:
>>Bruno Ducrot wrote:
>>>On Fri, Apr 15, 2005 at 10:50:44PM +0200, Janosch Machowinski wrote:
>>...
>>>>Oh I almost forgot another question : 
>>>>About the validation of the C states. At the moment it is tested if the
>>>>latency of C2 if under 100 and if C3 latency is under 1000 but the
>>>>ACPI-Spec says that "There is no latency restrictions" so why do you do
>>>>this ? (My notebook hat a C3 latency of 1001)
>>>Normally you are right, but unfortunately there are still some strange
>>>misread of the specification by bios writters in that regard.  Therefore
>>>if for C3 the latency is 1001 even if given by _CST, we should disable
>>>it.
>>>
>>My spec says (Revision 3.0, September 2, 2004):
>>The worst-case hardware latency for this state is declared in the FADT
>>(p. 257).
>>
>>And there they say (p. 98):
>>The worst-case hardware latency, in microseconds, to enter and
>>exit a C2 state. A value > 100 indicates the system does not
>>support a C2 state.
>>The worst-case hardware latency, in microseconds, to enter and
>>exit a C3 state. A value > 1000 indicates the system does not
>>support a C3 state.
>>
> 
> For P_LVL2_LAT and P_LVL3_LAT defined in the FADT only.  There are no
> such restriction if _CST exist (see 8.1.5 and 8.4.2).
> If power states are defined via _CST, then all of them are valid.
> 

Thanks, only knew of the fadt restrictions.
This should fix it?
Only compile tested.

       Thomas

--------------070406020900000604060100
Content-Type: text/plain;
 name="CST_long_latencies"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="CST_long_latencies"

Patch allows longer latencies for _CST provided c-states.
(cmp. with ACPI spec (see 8.1.5 and 8.4.2)).

--- linux-2.6.11.orig/drivers/acpi/processor_idle.c	2005-03-02 08:38:25.000000000 +0100
+++ linux-2.6.11/drivers/acpi/processor_idle.c	2005-04-19 13:47:17.000000000 +0200
@@ -646,7 +646,8 @@
 }
 
 
-static void acpi_processor_power_verify_c2(struct acpi_processor_cx *cx)
+static void acpi_processor_power_verify_c2(struct acpi_processor *pr,
+					   struct acpi_processor_cx *cx)
 {
 	ACPI_FUNCTION_TRACE("acpi_processor_get_power_verify_c2");
 
@@ -657,7 +658,7 @@
 	 * C2 latency must be less than or equal to 100
 	 * microseconds.
 	 */
-	else if (cx->latency > ACPI_PROCESSOR_MAX_C2_LATENCY) {
+	else if (!pr->flags.has_cst && cx->latency > ACPI_PROCESSOR_MAX_C2_LATENCY) {
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 				  "latency too large [%d]\n",
 				  cx->latency));
@@ -695,7 +696,7 @@
 	 * C3 latency must be less than or equal to 1000
 	 * microseconds.
 	 */
-	else if (cx->latency > ACPI_PROCESSOR_MAX_C3_LATENCY) {
+	else if (!pr->flags.has_cst && cx->latency > ACPI_PROCESSOR_MAX_C3_LATENCY) {
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 				  "latency too large [%d]\n",
 				  cx->latency));
@@ -757,7 +758,7 @@
 			break;
 
 		case ACPI_STATE_C2:
-			acpi_processor_power_verify_c2(cx);
+			acpi_processor_power_verify_c2(pr, cx);
 			break;
 
 		case ACPI_STATE_C3:

--------------070406020900000604060100--


-------------------------------------------------------
This SF.Net email is sponsored by: New Crystal Reports XI.
Version 11 adds new functionality designed to reduce time involved in
creating, integrating, and deploying reporting solutions. Free runtime info,
new features, or free trial, at: http://www.businessobjects.com/devxi/728
