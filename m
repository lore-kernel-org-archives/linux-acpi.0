From: Bob Weber <rjweber-EkmVulN54Sk@public.gmane.org>
Subject: Re: Compile problem in DSDT.dsl file
Date: Mon, 24 Jan 2005 21:02:28 -0800
Message-ID: <200501242102.28889.rjweber@ieee.org>
References: <200501101200.13340.rjweber@ieee.org> <20050117130819.GA8558@hell.org.pl> <200501192246.58642.rjweber@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200501192246.58642.rjweber-EkmVulN54Sk@public.gmane.org>
Content-Disposition: inline
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

I've found why I could not boot the kernels with ACPI. I need to disable the 
local APIC option (nolapic). After this, ACPI works. There are still 
complaints, but at least it'll run and you can see debug msgs.

This may be old news, but I didn't find any suggestion in the archives. Even 
though it's not an ACPI problem, it can appear as such because disabling ACPI 
also allows the kernel to boot. I'm not sure how ACPI and APIC interact on my 
laptop. So, I thought a post that mentions this would be good.

It doesn't solve the compile problem for the DSDT file, and there are probably 
limitations, at least it's workable.

- Bob


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
