From: Mark Goldman <bitshifter-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Fixing ACPI problems with drivers.
Date: Fri, 28 Jan 2005 12:27:47 -0500
Message-ID: <f561de7305012809276dbd2e83@mail.gmail.com>
Reply-To: Mark Goldman <bitshifter-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

I am currently trying to hunt down problems with ACPI and the drivers
that my laptop uses.  Currently, every device I use works under APM. 
If I use a very minimal set of drivers with ACPI, I can often get
suspend to ram (S3) and resume from ram to work.

I'm not afraid to muck about in the kernel and I want to track down
these irritating problems with acpi.  That said, does anyone have any
advice for how to go about finding which drivers work under APM and
not ACPI without doing dozens of kernel compiles?  Also, is there any
way to do a "dry run" of a suspend to ram to see what would be called
on my particular computer?

-Mark Goldman
Ohio University
-- 
"50% of marriages today end in divorce, the other 50% end in death. 
Which would you rather have?"


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
