From: Michael Grigoriev <mag-wxkiEGMmYARAfugRpC6u6w@public.gmane.org>
Subject: Regression: S4/S5 wake up immediately
Date: Thu, 02 Sep 2004 15:46:25 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <pan.2004.09.02.22.46.23.624873@luminal.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

My laptop (HP ZT3000 series) does not seem to be able to reliably enter S4
and S5 states anymore. It used to work with 2.6.7-mm2, but with
2.6.8.1-mm2 and 2.6.9-rc1 + acpi-20040816, it powers down (harddrive
clicks off, leds go out, etc), but then turn back on right away.

Any idea what's changed between now and then that could lead this
behaviour? If not, any clues on how to debug it?

-- 
Have fun,                                      "I tried to no avail
Michael "mag" Grigoriev           To keep my eyes from growing pale
mag-wxkiEGMmYARAfugRpC6u6w@public.gmane.org                         But my vision came too late
http://www.luminal.org               And my belief started to abate"



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
