From: Johannes Kuhlmann <jkuhlmann-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: first shoot for smartbattery
Date: Tue, 4 Jan 2005 15:45:18 +0100
Message-ID: <47e0449d05010406454e59b16a@mail.gmail.com>
References: <41D56002.5060008@mega.ist.utl.pt>
	 <20050101082605.GA24896@phys.ethz.ch>
	 <m2acrth375.fsf@phoenix.squirrel.nl>
	 <20050103143902.GQ19199@poupinou.org>
	 <41D97AF3.7000409@arrakis.dhis.org>
	 <41D98251.9020002@arrakis.dhis.org>
	 <20050103180219.GX19199@poupinou.org>
	 <41D9A1F5.1060508@arrakis.dhis.org>
	 <20050104100844.GA19199@poupinou.org> <41DAA92C.4080605@tiscali.be>
Reply-To: Johannes Kuhlmann <jkuhlmann-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <41DAA92C.4080605-IWqWACnzNjyZIoH1IeqzKA@public.gmane.org>
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

I'm trying this out on an Acer Travelmate 4001LCi. With the version of
today, I get nice results for the battery, though I experienced the
same you did. But as fas as I could see this behaviour only takes
place, if I run smartbattery repeatedly with a very short delay. If I
only run it from time to time, it seems to be decreasing normally.
What I also experienced is, that it takes some time (not too long)
when plugging in the AC adapter until smartbattery shows the time to
be full (and some other information). Immediately I can see three
values, but not all that are normally shown. Sorry, I can't remember
which and I'm currently at another machine.

Regards,
Johannes

On Tue, 04 Jan 2005 15:33:16 +0100, Fran=E7ois Valenduc
<fvalenduc-IWqWACnzNjyZIoH1IeqzKA@public.gmane.org> wrote:
> I am afraid it's not ok yet. In fact I get a very strange result: when
> the AC adapter is unplugged and knowing my battery is fully loaded, if I
> run repeatedly the command smartbattery 0, the "time to empty value" is
> sometime increasing, sometime decreasing. I can understand that it
> decreases but it's strange that it can also increase ! Last
> precision: I did this test with the latest available release (after
> having replaced the smartbattery.c file by a new version that Brunot
> Ducrot send me this morning to fix compilation errors).
>


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
