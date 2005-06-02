From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: DSDT Problems with Acer Aspire 1691WLMi
Date: Thu, 2 Jun 2005 17:14:53 +0200
Message-ID: <20050602151453.GD8899@poupinou.org>
References: <1117711110.7363.9.camel@localhost.localdomain> <429F1315.80600@altern.org> <429F1FE0.9080208@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <429F1FE0.9080208-l3A5Bk7waGM@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Cc: DJAX <djax-whniv8GeeGkdnm+yROfE0A@public.gmane.org>, ACPI <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, dani-fQczH/8Hd3rnGZpH1ro7E16hYfS7NtTn@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Jun 02, 2005 at 05:04:00PM +0200, Thomas Renninger wrote:
> If this is a common problem on many machines maybe the compiler should be a bit less restricted
> at this point?
> 

Not supported :)

--- acpica-unix-20050513/compiler/aslrestype2.c	2005/05/30 18:26:54	1.1
+++ acpica-unix-20050513/compiler/aslrestype2.c	2005/05/30 18:29:01
@@ -329,7 +329,7 @@ RsDoDwordIoDescriptor (
              * Not a valid ResourceSource, ResourceSourceIndex must also
              * be invalid
              */
-            else if (ResSourceIndex)
+            else if (0)
             {
                 AslError (ASL_ERROR, ASL_MSG_RESOURCE_SOURCE,
                     InitializerOp, NULL);
@@ -543,7 +543,7 @@ RsDoDwordMemoryDescriptor (
              * Not a valid ResourceSource, ResourceSourceIndex must also
              * be invalid
              */
-            else if (ResSourceIndex)
+            else if (0)
             {
                 AslError (ASL_ERROR, ASL_MSG_RESOURCE_SOURCE,
                     InitializerOp, NULL);
@@ -755,7 +755,7 @@ RsDoDwordSpaceDescriptor (
              * Not a valid ResourceSource, ResourceSourceIndex must also
              * be invalid
              */
-            else if (ResSourceIndex)
+            else if (0)
             {
                 AslError (ASL_ERROR, ASL_MSG_RESOURCE_SOURCE,
                     InitializerOp, NULL);
@@ -1428,7 +1428,7 @@ RsDoQwordIoDescriptor (
              * Not a valid ResourceSource, ResourceSourceIndex must also
              * be invalid
              */
-            else if (ResSourceIndex)
+            else if (0)
             {
                 AslError (ASL_ERROR, ASL_MSG_RESOURCE_SOURCE,
                     InitializerOp, NULL);
@@ -1637,7 +1637,7 @@ RsDoQwordMemoryDescriptor (
              * Not a valid ResourceSource, ResourceSourceIndex must also
              * be invalid
              */
-            else if (ResSourceIndex)
+            else if (0)
             {
                 AslError (ASL_ERROR, ASL_MSG_RESOURCE_SOURCE,
                     InitializerOp, NULL);
@@ -1844,7 +1844,7 @@ RsDoQwordSpaceDescriptor (
              * Not a valid ResourceSource, ResourceSourceIndex must also
              * be invalid
              */
-            else if (ResSourceIndex)
+            else if (0)
             {
                 AslError (ASL_ERROR, ASL_MSG_RESOURCE_SOURCE,
                     InitializerOp, NULL);
@@ -2032,7 +2032,7 @@ RsDoWordIoDescriptor (
              * Not a valid ResourceSource, ResourceSourceIndex must also
              * be invalid
              */
-            else if (ResSourceIndex)
+            else if (0)
             {
                 AslError (ASL_ERROR, ASL_MSG_RESOURCE_SOURCE,
                     InitializerOp, NULL);
@@ -2232,7 +2232,7 @@ RsDoWordBusNumberDescriptor (
              * Not a valid ResourceSource, ResourceSourceIndex must also
              * be invalid
              */
-            else if (ResSourceIndex)
+            else if (0)
             {
                 AslError (ASL_ERROR, ASL_MSG_RESOURCE_SOURCE,
                     InitializerOp, NULL);
@@ -2429,7 +2429,7 @@ RsDoWordSpaceDescriptor (
              * Not a valid ResourceSource, ResourceSourceIndex must also
              * be invalid
              */
-            else if (ResSourceIndex)
+            else if (0)
             {
                 AslError (ASL_ERROR, ASL_MSG_RESOURCE_SOURCE,
                     InitializerOp, NULL);

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
