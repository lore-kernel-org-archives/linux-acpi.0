From: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Subject: Re: regression between -rc4 and -rc5
Date: Thu, 22 Dec 2005 21:38:39 +0100
Message-ID: <43AB0ECF.10302@suse.de>
References: <1c687cba0512180712oc9579cbi96e97b5c89e424fd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1c687cba0512180712oc9579cbi96e97b5c89e424fd-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Olaf Conradi <oohlaf-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Olaf Conradi wrote:
> 
> In the mean time I upgraded to kernel 2.6.15-rc4 and most problems
> disappeared. Still using the original DSDT. During heavy usage cpu
> temperature rises to 76-78, and never reaches 80.
> 
> Yesterday I upgraded to kernel 2.6.15-rc5, and during compilation of
> ndiswrapper, while browsing the internet, it shutdown. If I compile
> ndiswrapper and don't do anything else, the cpu temp touches 80
> briefly, but does not shutdown. Under -rc4 this does not happen.
> 
What you see is probably a bug that slipped in 2.6.15-rc5:
It totally disables the use of cpufreq for passive cooling.
I already pointed Len to it and as this is really sever I am sure it
will be added before 2.6.15 is out if possible.
Also see Dirk Mueller's mail (12/21/2005):
Subject: make cpu_has_cpufreq() work
or the bug:
http://bugzilla.kernel.org/show_bug.cgi?id=3410

   Thomas


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
