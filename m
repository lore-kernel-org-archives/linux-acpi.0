From: Stefan Seyfried <seife-T+3qhDtrTvDv8lqoKu5MV4HBZQ1bDw0s@public.gmane.org>
Subject: [PATCH] Can set all but active[2] temperature via trip_points
Date: Fri, 30 Apr 2004 16:16:38 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040430141637.GA5675@message-id.gmane0305.slipkontur.de>
References: <20040425055737.GA7358@home.larve.net> <20040426112550.GB23616@fuchi> <20040426214213.GA10794@message-id.gmane0305.slipkontur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20040426214213.GA10794-l0tNAEGuAhhzZ8+rp42Dbp9+tswZ0GTaehPwdyo5hKaELgA04lAiVw@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Apr 26, 2004 at 11:42:16PM +0200, Stefan Seyfried wrote:
> On Mon, Apr 26, 2004 at 01:25:50PM +0200, Sebastian Henschel wrote:
> 
> > i had a little discussion with pavel machek about that a couple of weeks
> > ago. as written in 12.3.1, the acpi spec defines 10 active states.
> > the current implementation in linux is implemented for only 2 active
> > states, because pavel had not seen more than that before. he also told
 
> ok, i hacked some quick solution which WorksForMe[tm]. Note: i do not
> know C, so this could be terribly wrong. Anyway, this is the result:

HELLO, ACPI-DEVEL-LIST :-)

Anybody interested in this or am i on the wrong list here and need to
push this on LKML et al?

Since Pavel already voted for it, i would be glad to see this little bit
of useability make it into mainline.

Best regards,

   Stefan
-- 
Stefan Seyfried



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
