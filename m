From: Christoph Galler <listen-TsugTnnrXQsdc6zLPptBHg@public.gmane.org>
Subject: Acer Aspire 1654 WLMi
Date: Sat, 17 Dec 2005 01:47:01 +0100
Message-ID: <43A36005.1080608@ch.risto.ph>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
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

i just bought a new Acer Aspire notebook and after installing Gentoo
(Vanilla-Kernel 2.6.14.3) I unfortunately noticed that there is nearly
no ACPI support (just ac_adapter and buttons afaIk). That's not really
sad but I need at least the battery state if I'm away.

A "cat" on /proc/acpi/battery/BAT1/state shows me

present:	yes
ERROR: Unable to read battery status

/proc/acpi/battery/BAT1/info shows the right information about capacity,
model, vendor etc.

Are there any common/known issues about ACPI on Acer notebooks?

If you need more info, let me know. Thanks in advance.

Christoph


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
