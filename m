From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Report Toshiba Satellite300-214
Date: Mon, 3 Mar 2003 20:41:39 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030303194139.GA3918@poup.poupinou.org>
References: <microsoft-free.m3k7fg49lq.fsf@grisu.schuckeduster.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <microsoft-free.m3k7fg49lq.fsf-NYHFM3qjxh+4Q6RjEJEvzQmWJwt+BgR4@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Thomas Kosch <t.kosch-FfjHXTYIe3sI54nVjq4dGti2O/JbrIOy@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Mar 03, 2003 at 06:56:49PM +0100, Thomas Kosch wrote:
> Hi,

...

> The prozessor is alway in C2 state
> ,----
> | gryffindor:/proc/acpi # cat processor/CPU0/power
> | active state:            C2
> | default state:           C1
> | bus master activity:     ffffffff
> | states:
> |     C1:                  promotion[C2] demotion[--] latency[000] usage[00005860]
> |    *C2:                  promotion[C3] demotion[C1] latency[010] usage[00477940]
> |     C3:                  promotion[--] demotion[C2] latency[100] usage[00000000]
> | gryffindor:/proc/acpi #
> `----
> 

(I should read a little bit more before responding..)

It has been reported that using hci from usb will prevent correct
functionality with C3.  Without hci, it is OK (but you loose your
usb mouse alas).

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
