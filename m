From: Daniele Boffi <boffi-piYtxHxN1XRAly3Pu9w1wA@public.gmane.org>
Subject: Re: fan control
Date: Fri, 2 May 2003 10:31:02 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030502103102.A2867@fermat.unipv.it>
References: <B900970C7DD9474C972986EB3EC7C58F12EC9A@andromeda.agcad.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <B900970C7DD9474C972986EB3EC7C58F12EC9A-PWLG29+z7hEKeIAE67mlpo2P0GrZ+RbP@public.gmane.org>; from Herbert.Nachtnebel-8zxNtbQCHXIjuwv8T7myQQ@public.gmane.org on Fri, May 02, 2003 at 10:17:22AM +0200
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Herbert Nachtnebel <Herbert.Nachtnebel-8zxNtbQCHXIjuwv8T7myQQ@public.gmane.org>, raul.aranda-fE4FmR91nWqXOwHavGvsmg@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> > > > I understand this procedure might be very dangerous. How am I sure that, after
> > > > playing with the fans, the control of them goes back to the thermal zones?
> > > 
> > >   After stop it, try to compile a kernel, it must level up the
> > > temperature and spin up the fan.
> > > 
> 
> Yes it will, if not please report it to the list.

Herbert and Raul,

Thanks for your help.

Indeed, it seem that after rebooting my machine forgets about the fact that I
was playing with the fan status. What I don't understand in Raul's message is
why I should compile a new kernel. The one I have is OK and does not seem to be
screwed up by my experiments with the fan. Should it be? This is what seems
like from Herbert's message. I don't want to make experiments with the risk of
burning my CPU, but yesterday night (after a reboot) the (outside) temperature
was low and the fan was off, even though in my previous experiment I put it in
position one. This for me is the confirmation that everything is OK. What I
don't know yet is whether this is OK also within the same session. If there is
any documentation about that, please let me know (for instance, I found echo 0
and echo 3 just by guessing).

Daniele



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
