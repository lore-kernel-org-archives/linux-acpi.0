From: Timo Hoenig <thoenig-dCxI//HcOdFeoWH0uzbU5w@public.gmane.org>
Subject: Re: Fwd: [ACPI-bugzilla] acpi doesn't work sometimes
Date: Tue, 29 Nov 2005 09:57:21 +0100
Message-ID: <1133254641.25720.13.camel@linux.site>
References: <200511291341.02349.luming.yu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200511291341.02349.luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: soeren.wellhoefer-hi6Y0CQ0nG0@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi,

cc'ing Soeren.

On Tue, 2005-11-29 at 13:41 +0800, Yu, Luming wrote:

> I am using an acer notebook with suse 10.0.
> 
> ACPI seems to not work arbitrarily. Sometimes it work and is started during
> boot, sometimes not.
> 
> I often get the message by kpowersave, that it could not start because of
> not running acpi.
> 
> When trying to restart i get this message:
> 
> acpid: can't open /proc/acpi/event: Device or resource busy
> 
> What's the problem and why is it so arbitrary?

Some other daemon process acquired the the event interface before
powersaved could.  Identify the process with

   lsof |grep "/proc/acpi/event"

In rare cases its known that users encounter races between services for
the ACPI event interface.  Only acpid should access the kernel interface
directly; other user space processes should use the socket of acpid to
collect ACPI events.

Since you're using SL 10.0 I suspect you're packages are not up-to-date.

As a fortuneteller:  You've installed mobile selection of SUSE 10.0,
thus IAL (iald) is running which acquires the ACPI event interface as
fallback.  On a Acer notebook its safe to drop iald.

> I considered that it might be, that X is started before acpi. So I've
> already tried to reset the order at media:/hda6/etc/init.d/rc .
> 
> But this doesn't work...
> 
> regards
> 
> Soeren Wellhoefer

   Timo



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
