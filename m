From: "Wang, Zhenyu Z" <zhenyu.z.wang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: fan control based on temp
Date: Thu, 17 Jun 2004 10:46:18 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <6E0C289723A0564F9A8279E236E8565F07A000D1@pdsmsx402.pd.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Dan <overridex-Kz9Au3A7zptBDgjK7y7TUQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I can't extract DSDT from your file.
Do you use pmtool from kernel.org?
http://www.kernel.org/pub/linux/kernel/people/lenb/acpi/utils/

acpidmp DSDT > a
iasl -d a
and attach the a.dsl output

-zhen 

-----Original Message-----
From: Dan [mailto:overridex-Kz9Au3A7zptBDgjK7y7TUQ@public.gmane.org] 
Sent: 2004年6月17日 10:23
To: Wang, Zhenyu Z
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Subject: RE: [ACPI] fan control based on temp

On Wed, 2004-06-16 at 22:10, Wang, Zhenyu Z wrote:
> This is a known issue on some laptops.
> http://bugme.osdl.org/show_bug.cgi?id=2026
> 
> Pls, attach your acpidump output.
> 
> -zhen 

hmm, and I am on a 2.6.x kernel... acpidump output's attached -Dan

============================
-Dan "OverrideX"-
ICQ: 7171522
AIM: OverrideX
Jabber: OverrideX-/eSpBmjxGS4dnm+yROfE0A@public.gmane.org

"How to make a million dollars: First, get a million dollars." -- Steve
Martin



-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
