From: "Knut Neumann" <knut.neumann-4bfl1RV3iZDOEhgYWvzSCYQuADTiUCJX@public.gmane.org>
Subject: Re: ospmd
Date: Fri, 11 Oct 2002 14:02:51 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <00ac01c2711e$207a2ab0$5b0aa8c0@TRINITY>
References: <EDC461A30AC4D511ADE10002A5072CAD0236DF19@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Andy,

I am cc:ing to acpi-devel in case someone is interested in that discussion.

 > There are several important changes that your patch makes:
>
> 1) the pm interface returns info in a linked list to the generic ospmd
code
> 2) the size of data associated with a given request is now variable,
> depending on, for example, how many AC adapters there are.
> 3) libpower de-serializes the request into a linked list, and then returns
> that linked list to the caller.
>
> I don't like #1 because it causes a memory leak. The linked list appears
to
> never be deallocated. This is C++, so passing around vectors would be one
> way to have the list deallocation happen automatically.

Uhm...you are right. I am too much a C programmer - and the dealloc somehow
got lost when cleaning up the code for diff'ing. Anyway I will change the
code to use vectors then.

> I like #2. However, we should change the names of ospm_send_data and
> ospm_return_data to reflect that one assumes a fixed-length data packet
per
> message type, whereas the other one doesn't.

Agreed.

> #3 is also bad because we are asking the caller to deallocate the linked
> list we allocated. The caller should allocate either an array of
> PM_THERMAL_DATAs, which we fill in, or allocate a single PM_THERMAL_DATA,
> and we return the right info, based on a key that they pass in.

Thats a design issue. If you want linked lists the caller has to deallocate
them (for which I could provide a convenience function - so the caller would
not have to walk the whole list).

I do not like fixed length arrays - the caller can not know the number of
entries for a certain subsystem (eg 2 thermal zones) in advance.

The last suggestion seems the best. Though we would somehow have to provide
a list of keys. We might simply use the order number in the subsystem
directory here...that way there would be no need to change the send/receive
stuff . From libpower we could request the n-th entry and get it back just
the way its done now (with some changes to submit and return the number). In
ospmd we then would not need to use vectors since we could simply read the
n-th entry and return it - could be done with the actual code and some
slight mods. Actually that would still mean some fair amount of work for the
caller - in case it wants to read all entries (it has to to a for or while
and set up a dynamic array)....and thus for the policy-handler in ospmd too.
If you like it that way I will give it a try and start implementing it.

> Another nice thing would be a new page added to the GUI for thermal data.
> The gui code sucks and is a pain to work with, but it is very useful to
have
> a client application that actually uses the data libpower is providing.

Yup. I have no idea about how qt works and even had some problems getting
the gui compiled (it does not work with qt3) - so I would be very happy if
someone could write it. If no one stands up here, I will write it to test
the libpower code, when I did the changes.

Finally I have to admit that - right now - I feel having linked lists (at
least in libpower) and force the caller to deallocate mem is the best way to
do it, but I understand your concerns about mem leaks.

-Knut




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
