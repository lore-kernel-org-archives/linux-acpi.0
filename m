From: Fred Labrosse <ffl-4CLdheC3Iye1Qrn1Bg8BZw@public.gmane.org>
Subject: 2.4.26 does not shut down any more
Date: Mon, 5 Jul 2004 08:59:39 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <16617.2667.116655.228757@aber.ac.uk>
References: <40E8F027.7080201@sbox.tugraz.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <40E8F027.7080201-ArvQUR6U0fYD0fefG/KofA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Gerfried Maier <moali-ArvQUR6U0fYD0fefG/KofA@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Gerfried Maier writes:
 > Hello!
 > 
 > This weekend I updated from 2.4.24 to 2.4.26 and experienced that 2.4.26 
 > (in contrary to 2.4.24) does not shut down my notebook any more:
 > 
 > The screen is cleared, but the backlight of the LCD still on, power-led 
 > remains lit, no reaction to any keystrokes. The system needs the 10 
 > second-powerbutton to power off, then.
 > 
 > If I can contribute anything resolving this, please let me know.
 > 
 > Maier Gerfried
 > 
 > PS.: My system is an Acer Travelmate 630, with a vanilla 2.4.24 resp. 2.4.26
 > 

Try getting rid of the enhanced (is that how it's called?) RTC in the
kernel, that solved it for me and others.

Hope this helps.

Fred

P.S.  There's been quite a lot on the subject recently on the list.  Look
in the archives (search for "power down").



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
