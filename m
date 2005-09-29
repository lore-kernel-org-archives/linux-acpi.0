From: Hendrik Visage <hvjunk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Tried to fix DSDT on Acer Ferrari 3000
Date: Thu, 29 Sep 2005 08:38:45 +0200
Message-ID: <d93f04c705092823385c3d3825@mail.gmail.com>
References: <3aef9cce0509281334457a6748@mail.gmail.com>
Reply-To: Hendrik Visage <hvjunk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <3aef9cce0509281334457a6748-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Richard Stellingwerff <remenic-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On 9/28/05, Richard Stellingwerff <remenic-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> Pretty much everything regarding to ACPI works, as far as I can tell.
> Except for suspending to RAM. Suspending to disk using swsusp2 works
> fine. However, I'd really like STR to work as well.

Don't use swsusp2 but the stock standard 2.6.13 kernel swsusp, and I have t=
he
same symptoms with my Ferrari 3400.
My only other "concern" w.r.t. ACPI is that my battery status doesn't
get updated sometimes after a suspend resume.

> What happens when I run 'echo "mem" > /sys/power/state' is that the
> system goes to sleep. When I press any key to resume, the fan goes on,
> the dvd drive's LED flashes a few times, but the screen stays black.
> The system doesn't beep when I press backspace, can't be pinged, and
> won't shut down with ctrl+alt+del or by tapping the power button.
>
> So, I am hoping that anyone will more insight into ACPI is able to
> identify the cause by looking at (one of) the attached DSDT.
>
> Please, I'm very desperate. I have a bugreport of almost 1 years old
> in  bugzilla.kernel.org, but no one has taken time to look into it
> yet. You are my only hope! ;)
>
> Kind regards,
> Richard Stellingwerff.
>
>
>


--
Hendrik Visage


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
