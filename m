From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: list of features
Date: Wed, 4 Jun 2003 16:09:29 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030604140929.GI19556@poupinou.org>
References: <18543.1054732855@www39.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <18543.1054732855-b6xzuBWAMbNmcu3hnIyYJQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: tristan gestim <tripledelta-hi6Y0CQ0nG0@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Jun 04, 2003 at 03:20:55PM +0200, tristan gestim wrote:
> hello,
> i spent the last hour searching for a detailed list of feature for
> the 2.4 but also 2.5 patch. afaik 2.4 doesnt support any kind of
> standby (except swsup thing). is this right? when do you plan
> to integrate that? is there a time map or something.

2.4 support only S1 and S4 but via S4bios (and require then
that bios support S4bios, and you may have to create
a hibernate partition).

There is no plan (at least from me) to support anything else
for 2.4.

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
