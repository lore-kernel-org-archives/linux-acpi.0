From: Hugo Haas <hugo-rQR7RsZM/uVeoWH0uzbU5w@public.gmane.org>
Subject: Semi-success story: Compaq Evo N410c
Date: Sat, 8 Mar 2003 08:12:58 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030308131257.GB1533@home.larve.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi.

I have seen people posting DSDT questions here, and found lots of
useful pointers in the archive, so I am sending a report on getting
ACPI to work on a Compaq Evo N410c.

In a nutshell, some things were not detected, such as the fan, which
was a problem. After tweaking the DSDT, I got rid of most errors
(although one of my fixes is slightly random) and got most things
working. It is now usable. The fan is always on though, but I guess
that it's better than always off!

I noted that the errors I got were _really_ similar to errors that
people with N600c got. I would appreciate a pointer to a diff of the
DSDT to try and complete my fixes since it seems that there were a few
discussions about this one.

The errors I have left are about non existing objects that I have no
clue about:

| dsdt.dsl    53:             If (LEqual (\C001, 0x00))
| Error    1022 -       Object does not exist ^  (\C001)
| 
| dsdt.dsl  5602:                 \_PR.C000
| Error    1022 -   Object does not exist ^  (\_PR.C000)
| 
| dsdt.dsl  5642:                 \_PR.C000
| Error    1022 -   Object does not exist ^  (\_PR.C000)
| 
| dsdt.dsl  5710:                         Notify (\_PR.C000, 0x80)
| Error    1022 -                   Object does not exist ^  (\_PR.C000)

Since I found it quite hard to find information to get a working ACPI,
I have documented what I have done, with the DSDT, the diffs, etc.
Hopefully that will be useful to people:

	 http://larve.net/people/hugo/2003/03/acpi-n410c.html

If anybody has insight about how to get the fan not to always be on
and how to fix the rest of my errors, in particular Evo N600c owners,
I'd be grateful.

Regards,

Hugo

-- 
Hugo Haas - http://larve.net/people/hugo/


-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
