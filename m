From: =?windows-1251?b?wOvl6vHg7eTwIMvg4vDo7eXt6u4=?= <alavrinenko-74IzsnFj8nQvJsYlp49lxw@public.gmane.org>
Subject: FSC Amilo M3438G - some problems
Date: Mon, 28 Nov 2005 14:41:39 +0300
Message-ID: <200511281441.40092.alavrinenko@arbatek.ru>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="windows-1251"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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


Hello,

I've got FSC Amilo M3438G recently and installed OpenSuSE 10.1 Alpha3 on it. 
Kernel is 2.6.14. The first problem is that fan is always running on low RPM 
and there's nothing in /proc/acpi/fan/ directory (should be at least 
FAN0/state).

Next problem is when I use built-in synaptics touchpad, KDE's klaptop daemon 
reports 'AC online BAT full' -> 'AC online BAT discharged' -> 'AC offline BAT 
full' -> 'AC offline BAT discharged' cycling endlessly if I move finger over 
touchpad. As soon as I stop touching the pad, events stop being generated, 
reverting to 'AC online BAT full'. So I have to use external USB mouse right 
now.

Please add support for this great laptop - if you need any debug output or 
other messages/info, feel free to ask.

Thanks in advance.

Alex Lavrinenko


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
