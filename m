From: mike <mike-rSZvBvsYROxg9hUCZPvPmw@public.gmane.org>
Subject: smartbattery swsusp and acpi-sbs
Date: Tue, 18 Jan 2005 20:09:08 +0700
Message-ID: <20051182098.998032@p4>
References: <20050118081428.909488835A@sc8-sf-spam1.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050118081428.909488835A-MRDXTZLjjMs+bN4EscsFoaQD96bmaF075NbjCUgZEJk@public.gmane.org>
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

i'm having success with the above features.  Currently I'm-a-runnin 2.6.10=
 with support for swsusp.  I have the smartbattery(i2c-dev) and I'm using=
 Mr. Townsend's i2c-acpi-ec which I think he said is slightly modified from=
 someone  who's name escapes me sorry. I'm also using acpi-sbs.. My machine=
 is an ACER 3200Xci which is just like the "ferrari" 3200 but I live in ASIA=
 so maybe it's slightly different.

I am also able to suspend using swsusp core (2.1.5.12). But I must remove=
 all the i2c modules or we get a nasy!  Before I didn't remove the modules=
 and swsusp failed to resume (it suspend okay) but I think i2c-core module=
 was causing the a problem.  Now using Mr. Townsend's stuffs, it suspends=
 and resumes just dandy.  it looks like i2c core functionality is fine after=
 re-inserting the modules.  Thanks heaps by the way I was so bummed about=
 this smart battery issue..

Now 3 error messages:

when removing the i2c-dev modules I get the following:
"i2c-dev does not have a release() function, be careful"
"i2c-adaptor does not have a release() function, be careful"
"Kernel: losing some ticks... checking if CPU frequency changed"
I notice this message happens every 30 seconds which corresponds to the=
 setting I have for gkrellm to poll the /proc attery dir  I remember seeing=
 someone mention that i2c reads are very slow and causes the entire system=
 to lock up.. well I rekon this is happening to me.. Is "losing ticks" a bad=
 thing?

Finally an observation:
Upon engaging the battery and subsequently charging again, I notice the=
 battery light comes on and off (in my case it the LED goes from "off not=
 lit" state to "orange" charge state roughly every 62 seconds ( I was hoping=
 it would be 30 seconds) but no such luck.  This seems to be reported by=
 other people as well.

Okay thanks again for this, its a killer ap dude

mikel



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
