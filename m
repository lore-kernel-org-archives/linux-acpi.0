From: David =?iso-8859-15?Q?G=F3mez?= <david-0d+f1cuTMnnk1uMJSBkQmQ@public.gmane.org>
Subject: Re: No battery and AC_adapter detected
Date: Thu, 9 Sep 2004 00:21:31 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040908222131.GA2406@fargo>
References: <200409082334.21305.n.manel@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200409082334.21305.n.manel-GANU6spQydw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Nicolas MANEL <n.manel-GANU6spQydw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Nicolas ;),

On Sep 08 at 11:34:21, Nicolas MANEL wrote:
> Hello
> My Laptop is a acer 1682.
> I'm running under an unstable debian.
> I have compiled a 2.6.8.1, I had patched with the last 2.6.8 patch.
> I had actived every ACPI options.
> But directorys /proc/acpi/battery and /proc/acpi/ac_adaptor are empty. =
And=20
> Even KDE says they are missing.

Same case here ;), but with acer 4001LMi. Look at my message from the
previous week, probably you suffer the same problem. Currently battery
module only supports standard batteries, but not 'smart' batteries. That'=
s
why the don't appear in /proc.=20

Shaohua said he's working on it :)

cheers,

--=20
David G=F3mez

"The question of whether computers can think is just like the question of
 whether submarines can swim." -- Edsger W. Dijkstra


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
