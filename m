From: Miroslav Ruda <ruda-8qz54MUs51PtwjQa/ONI9g@public.gmane.org>
Subject: S3+S4 combination fails on M2000E
Date: Thu, 20 Jan 2005 10:47:59 +0100
Message-ID: <41EF7E4F.9060502@ics.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

Hi,

  I have Asus M2000E, running 2.6.10+acpi patches (but the same problem appears 
with previous 2.6 kernels too, with Suse 2.6.5-7.111 and also with swsups2 
patches). Both suspend to disk and suspend to memory works, but I'm still not 
happy :-)

After suspend to memory is used, first suspend to disk is able to suspend, but 
machine is frozen in wake-up. When acpi modules are unloaded before suspend and 
loaded in wake-up, machine is frozen in first acpi module load (thermal?). When
acpi modules are left in kernel, laptop works fine several seconds (I'm even 
check batery status etc.) but then freeze (no message anywhere). When booted
with acpi=off, problem doesn't appear. The same problem is when suspending using
swsusp or swsusp2. When only suspend to disk or suspend to memory is used, 
problem never occures both when acpi modules are unloaded or left in memory.

Any idea?

Cheers,

              Mirek Ruda



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
