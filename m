From: moali-ArvQUR6U0fYD0fefG/KofA@public.gmane.org
Subject: Fwd: processor and thermal in acpi-20021022/2.4.20-re11
Date: Mon, 04 Nov 2002 08:57:40 +0100 (MET)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1036396660.3dc62874d6df8@sbox.tugraz.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Sorry for the unnecessary porting.

I should have read the anouncing and the release notes of the new version (acpi-
20021101) in SF first.

Maier Gerfried


----- Weitergeleitete Nachricht von moali-ArvQUR6U0fYD0fefG/KofA@public.gmane.org -----
Date: Mon, 04 Nov 2002 08:52:30 +0100 (MET)
From: moali-ArvQUR6U0fYD0fefG/KofA@public.gmane.org
Reply-To: moali-ArvQUR6U0fYD0fefG/KofA@public.gmane.org
Subject: processor and thermal in acpi-20021022/2.4.20-re11
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org

Hi!

I've just tried out the above mentioned acpi-patch against kernel 2.4.20-pre11
and I experienced, that the files (directories) /proc/acpi/thermal
and /proc/acpi/processor where not there any more (They have been there using
an erlier release e.g the one used in the Suse 8.1-kernel (unfortunately I do
not know bs now which version of acpi it was), but from this release the
thermal and/or the processor module caused an Oops resulting in a complete
standstill when unloading them). Have these directories been removed? Or is
this a malfunction of my system/configuration?

The modules thermal and processor load without any errors.

Thanks for your help
Maier Gerfried
----- Ende der weitergeleiteten Nachricht -----


-------------------------------------------------------
This SF.net email is sponsored by: ApacheCon, November 18-21 in
Las Vegas (supported by COMDEX), the only Apache event to be
fully supported by the ASF. http://www.apachecon.com
