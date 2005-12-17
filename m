From: Christoph Galler <listen-TsugTnnrXQsdc6zLPptBHg@public.gmane.org>
Subject: Re: 2.6.14.3 suspend/resume with SMP (HT)
Date: Sat, 17 Dec 2005 01:30:01 +0100
Message-ID: <43A35C09.9040809@ch.risto.ph>
References: <59D45D057E9702469E5775CBB56411F10120CC53@pdsmsx406> <1134764243.27534.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1134764243.27534.4.camel-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
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

On 12/16/2005 09:17 PM, Karl H. Beckers wrote:

>> Am Freitag, den 16.12.2005, 10:12 +0800 schrieb Li, Shaohua:
>> Seems to work,
>>
>> will try once more in single-user mode with all services stopped and
>> modules unloaded like when I suspended and keep you posted.


I don't know if it solves your problem, but i had to activate "Support
for hot-pluggable CPUs (Experimental)" (CONFIG_HOTPLUG_CPU=y) in kernel
to get suspend to disk working with my Pentium 4 HT. Maybe it helps.

Christoph



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
