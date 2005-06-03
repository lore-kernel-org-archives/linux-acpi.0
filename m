From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: swsusp not working for me on a PREEMPT 2.6.12-rc1 and 2.6.12-rc1-mm3 kernel
Date: Fri, 3 Jun 2005 17:25:40 +0200
Message-ID: <20050603152540.GF3867@elf.ucw.cz>
References: <20050329110309.GA17744@pern.dea.icai.upco.es> <20050525212520.419ee442.akpm@osdl.org> <20050603094448.GA3218@pern.dea.icai.upco.es> <20050603105010.GA7300@pern.dea.icai.upco.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20050603105010.GA7300-NfIQswJzSEaq9fEpoSJUslHdEuJhDOxL@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Romano Giannetti <romano-1BxYRfzsdQW8A8a7gxElqg@public.gmane.org>
Cc: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> > > Romano, are you able to tell us whether 2.6.12-rc5 or 2.6.12-rc5-mm1 still
> > > exhibit this hang?
> > 
> > 
> > I have tried vanilla 2.6.11-rc5 WITHOUT preempt. swsusp works OK but the
> > acpi keys (suspend, change monitor/LCD) are delayed by 8-hit as explained 
> > in http://bugme.osdl.org/show_bug.cgi?id=4124#c2 
> > 
> > I am compiling 2.6.11-rc5 with preempt now. Then I will do the same on -mm2.
> > Which "style" of preempt should I choose? 
> 
> Tried with vanilla-rc5 and preempt. Good news: now it suspends and resumes,
> with the problem that while resuming I have a lot of "scheduling while
> atomic" and the resume script segfaults (I do not know why, I didn't find
> oops). Reloading the modules and restarting usb manually (i.e., doing
> manually the rest of the script) make it works ok. Sort of, because
> battery module did not see my battery the first time, only the second time I
> load it.) After that, it works ok (it is compiling -mm2 now). 

Segfault of bash is expected when preempt counts go wrong. Could you
look at scheduling while atomic tracebacks, and just fix whatever
driver causes them? I do preempt swsusp here, and it works okay...
								Pavel


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
