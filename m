From: Daniele Boffi <boffi-piYtxHxN1XRAly3Pu9w1wA@public.gmane.org>
Subject: Re: fan control
Date: Fri, 2 May 2003 13:04:43 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030502130443.I2867@fermat.unipv.it>
References: <B900970C7DD9474C972986EB3EC7C58F0D409F@andromeda.agcad.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <B900970C7DD9474C972986EB3EC7C58F0D409F-PWLG29+z7hEKeIAE67mlpo2P0GrZ+RbP@public.gmane.org>; from Herbert.Nachtnebel-8zxNtbQCHXIjuwv8T7myQQ@public.gmane.org on Fri, May 02, 2003 at 12:50:48PM +0200
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Herbert Nachtnebel <Herbert.Nachtnebel-8zxNtbQCHXIjuwv8T7myQQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> > I am afraid I couldn't get it. I think the fans are sorted correctly (in
> > reverse order). Usally I see something like
> 
> That's really not difficult - you have
> 
> /proc/acpi/fan:
> C1D9  C1DA  C1DB  C1DC
> 
> and the alphanumeric ordering of the names of your FAN's don't represents the ordering in which they are activated from the thermal zone. If you now use ls/find/cat to display the state, you will not see the behaviour you expect.

OK, but the usual order they start is C1DC, C1DB, C1DA, and C1D9.
In that case I had C1DB on when C1DC was off and this sounds strange (I think
is an error in reporting the status of C1DC), unless the names of the fans
had changed (i.e., in what I call "strange situation", C1BD played the role
which is usually of C1DC).
I think it is more likely that C1DC was on and not reported (indeed from
the sound of the fan the speed, even difficult to detect exactly, seemed higher
than just one status on).

Daniele


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
