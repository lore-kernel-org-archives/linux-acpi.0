From: Olaf Conradi <oohlaf-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: regression between -rc4 and -rc5
Date: Sun, 25 Dec 2005 17:02:41 +0100
Message-ID: <1c687cba0512250802nde1e87du3ca9b39ac435cb6d@mail.gmail.com>
References: <1c687cba0512180712oc9579cbi96e97b5c89e424fd@mail.gmail.com>
	 <43AB0ECF.10302@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <43AB0ECF.10302-l3A5Bk7waGM@public.gmane.org>
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
To: Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi, thanks for your reply.

On 12/22/05, Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org> wrote:
> What you see is probably a bug that slipped in 2.6.15-rc5:
> It totally disables the use of cpufreq for passive cooling.
> I already pointed Len to it and as this is really sever I am sure it
> will be added before 2.6.15 is out if possible.
> Also see Dirk Mueller's mail (12/21/2005):
> Subject: make cpu_has_cpufreq() work
> or the bug:
> http://bugzilla.kernel.org/show_bug.cgi?id=3D3410

My processor does not support speedstep for frequency scaling, it only
supports throttling.

The bug you pointed to does not seem to be entirely cpufreq specific,
so maybe it is relevant. Am not sure.

How can I diagnose the problem? I can put the system under load by
compiling something, but how can I best monitor acpi?

Cheers and a merry xmas,
 -Olaf


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
