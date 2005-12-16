From: "Rolf Eike Beer" <eike-B90SbfZsE4eELgA04lAiVw@public.gmane.org>
Subject: Re: [PATCH 1/2] make acpi_path_name() global
Date: Fri, 16 Dec 2005 22:03:35 +0100 (CET)
Message-ID: <61535.84.131.57.100.1134767015.squirrel@sf-mail.de>
References: <F7DC2337C7631D4386A2DF6E8FB22B30056F8757@hdsmsx401.amr.corp.intel.com>
     <20051215212735.2065f4f4.rdunlap@xenotime.net>
    <1134758310.7096.3.camel@whizzy>
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1134758310.7096.3.camel@whizzy>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Kristen Accardi <kristen.c.accardi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "Randy.Dunlap" <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>, "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, randy_d_dunlap-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, pcihpd-discuss-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, gregkh-l3A5Bk7waGM@public.gmane.org, robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> On Thu, 2005-12-15 at 21:27 -0800, Randy.Dunlap wrote:
>> On Thu, 15 Dec 2005 23:56:47 -0500 Brown, Len wrote:
>
> <snip>
>> > an example of this is acpi_get_name(), which as declared
>> > isn't supposed to be available outside the core.
>> > All the uses of it to print ACPI namespace tokens in /proc
>> > are totally bogus and should be deleted.  The other use
>> > of it is to print out debug strings -- stuff the OS
>> > doesn't really need to "know" and maybe something the
>> > core should do for it.  That leaves the hotplug use,
>> > which I don't understand.  What does SATA need
>> > with the actual path names?
>>
>> SATA uses the name string for (a) debugging, as you have
>> mentioned, and (b) for comparing complete device strings
>> to match/find a SATA _ADR under a device (in a device's
>> scope).  I can do without (a) as well as the rest of the
>> kernel can, of course.  I don't know how to find and match
>> SATA devices (part b) without it, so this is an opportunity
>> for you to educate me.  :)
>>
>>
> We use this in pciehp and shpchp as well for the same reason.  One thin=
g
> I don't love about these patches is the need now to worry about freeing
> memory after you make these calls.  To me that seems like asking for
> memory leaks in error paths at some point down the road when someone
> less careful than Randy adds some code in.  If there were some way to
> return a pointer to a static string, I'd prefer that solution, but I
> can't figure out from looking at the acpi code if that is possible.  If
> there's some better way to perform this compare, I'd like to hear it
> too.

Don't do the allocation in the function but pass a buffer and it's length
to it. The caller can do dynamic allocation if needed or use a buffer on
stack if not. This also makes error handling easier as ENOMEM can't happe=
n
in acpi_path_name() anymore.

Eike


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log fi=
les
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=3D7637&alloc_id=3D16865&op=3Dclick
