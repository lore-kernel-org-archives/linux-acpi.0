From: Vojtech Pavlik <vojtech-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: FYI: ACPI 'sleep 1' resets atkbd keycodes
Date: Tue, 3 Feb 2004 08:37:06 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040203073706.GE337@ucw.cz>
References: <200401251137.21646.p_christ@hol.gr> <20040125115946.GA414@ucw.cz> <200402022338.48010.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200402022338.48010.dtor_core-yWtbtysYrB+LZ21kGMrzwg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Dmitry Torokhov <dtor_core-yWtbtysYrB+LZ21kGMrzwg@public.gmane.org>
Cc: "P. Christeas" <p_christ-U04EIuiosng@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, Feb 02, 2004 at 11:38:41PM -0500, Dmitry Torokhov wrote:

> I feel a little uneasy about killing the input device if set changes after
> resume. That would cause a new input device created but for user it would
> look like keyboard is lost or am I missing someting?

The console will automatically and immediately grab the new keyboard and
everything will continue to work, even X, because it uses the console
for input.

Later, when X uses the event interface, it'll get a notification that
the keyboard was removed and added again, which will cause it to open
the new one, so all will be OK, too.

> What about the patch below which would reset keyboard to the default keymap
> only if set changes?

I don't think there is a problem with just reconnecting. It's extremely
unlikely that the set can change, too, because everyone uses translated
set 2, and that's the lowest common denominator.

Unless you specified extra arguments on the kernel command line, you
can't get any other set.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
