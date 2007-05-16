From: Goulven Guillard <lecotegougdelaforce@free.fr>
Subject: Re: 2.6.22-rc1-mm1 [cannot change thermal trip points]
Date: Wed, 16 May 2007 20:10:25 +0200
Message-ID: <464B4911.4050903@free.fr>
References: <20070515201914.16944e04.akpm@linux-foundation.org> <464B4155.9070902@gmail.com> <464B43BB.3070505@redhat.com>
Reply-To: lecotegougdelaforce@free.fr
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ires.in2p3.fr ([193.48.86.184]:35103 "EHLO IReS.in2p3.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758412AbXEPSKA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 16 May 2007 14:10:00 -0400
In-Reply-To: <464B43BB.3070505@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Chuck Ebbert <cebbert@redhat.com>
Cc: Maciej Rutecki <maciej.rutecki@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, lenb@kernel.org

Le 05/16/2007 07:47 PM, Chuck Ebbert a d=C3=A9clar=C3=A9 :

> Gitweb:     http://git.kernel.org/git/?p=3Dlinux/kernel/git/torvalds/=
linux-2.6.git;a=3Dcommit;h=3D11ccc0f249cb01a129f54760b8ff087f242935d4
> Commit:     11ccc0f249cb01a129f54760b8ff087f242935d4
> Parent:     de46c33745f5e2ad594c72f2cf5f490861b16ce1
> Author:     Len Brown <len.brown@intel.com>
> AuthorDate: Mon Apr 30 22:36:01 2007 -0400
> Committer:  Len Brown <len.brown@intel.com>
> CommitDate: Mon Apr 30 22:36:01 2007 -0400
>=20
>     ACPI: thermal trip points are read-only


Should one understand that it IS a wanted behaviour ?

Isn't it the DSDT job (which is kernel-accessible, or isn't it ?) to
communicate trip_points to ACPI thermal zone ?

Isn't OSPM managing thermal zone ?

(http://acpi.sourceforge.net/documentation/thermal.html)




PS : Sorry for all these (maybe stupid) questions, but I think I
remember that changing trip_points had an effect on a (DSDT-bugged)
laptop I used to use, and I'd like to understand...

PPS : Sorry also for the english mistakes or approximations...




--=20
    ~~
   |Oo|   La banquise fond !!! Adoptez un pingouin...
  /|\/|\
   |__|            =3D> http://doc.ubuntu-fr.org/
   ^__^
~~~|  |~~~








-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
