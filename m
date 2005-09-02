From: Couriousous <couriousous-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] IASL disassembler bug with "Missing EndDependentFunctions" comment
Date: Sat, 3 Sep 2005 00:09:44 +0200
Message-ID: <200509030009.44767.couriousous@gmail.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_o2MGDYeNWVSQn4b"
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

--Boundary-00=_o2MGDYeNWVSQn4b
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello 

Sorry if it's the wrong list/email, but I didn't found a better one. There is 
no email on Intel website about the iasl disassembler.

When a dependent resource list doesn't end with EndDependentFn() macro, the 
iasl disassembler print the following comment in the disassembled source:

//*** Missing EndDependentFunctions descriptor

But it forget to terminate the comment by \n. So, the "next line" is on the 
same line as the comment.

Regards,
Couriousous 

--Boundary-00=_o2MGDYeNWVSQn4b
Content-Type: text/x-diff;
  charset="us-ascii";
  name="EndDependentFunctions-comment-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="EndDependentFunctions-comment-fix.patch"

--- disassembler/dmresrc.c.origi	2005-09-02 23:16:41.000000000 +0200
+++ disassembler/dmresrc.c	2005-09-02 23:17:12.000000000 +0200
@@ -303,7 +303,7 @@
                 AcpiOsPrintf ("}\n");
                 AcpiDmIndent (Level);
 
-                AcpiOsPrintf ("//*** Missing EndDependentFunctions descriptor");
+                AcpiOsPrintf ("//*** Missing EndDependentFunctions descriptor\n");
 
                 /*
                  * We could fix the problem, but then the ASL would not match

--Boundary-00=_o2MGDYeNWVSQn4b--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
