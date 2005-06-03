From: Romano Giannetti <romano-1BxYRfzsdQW8A8a7gxElqg@public.gmane.org>
Subject: Re: swsusp not working for me on a PREEMPT 2.6.12-rc1 and 2.6.12-rc1-mm3 kernel
Date: Fri, 3 Jun 2005 12:50:10 +0200
Message-ID: <20050603105010.GA7300@pern.dea.icai.upco.es>
References: <20050329110309.GA17744@pern.dea.icai.upco.es> <20050525212520.419ee442.akpm@osdl.org> <20050603094448.GA3218@pern.dea.icai.upco.es>
Reply-To: romano-1BxYRfzsdQW8A8a7gxElqg@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20050603094448.GA3218-NfIQswJzSEaq9fEpoSJUslHdEuJhDOxL@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Cc: pavel-+ZI9xUNit7I@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Jun 03, 2005 at 11:44:48AM +0200, Romano Giannetti wrote:
> On Wed, May 25, 2005 at 09:25:20PM -0700, Andrew Morton wrote:
> > Romano Giannetti <romanol-qvIf60buks8@public.gmane.org> wrote:
> > >
> > > Hi all,
> > > 
 
> > >    When suspending, it stops dead with thi two lines (hand copied) 
> > >    
> > >    ACPI: PCI interrupt 0000:00:07.5 [C] -> GSI 5 (level, low) -> IRQ5
> > >    ACPI: PCI interrupt 0000:00:0e.0 [A] -> GSI 9 (level, low) -> IRQ9
> > >    

> > Romano, are you able to tell us whether 2.6.12-rc5 or 2.6.12-rc5-mm1 still
> > exhibit this hang?
> 
> 
> I have tried vanilla 2.6.11-rc5 WITHOUT preempt. swsusp works OK but the
> acpi keys (suspend, change monitor/LCD) are delayed by 8-hit as explained 
> in http://bugme.osdl.org/show_bug.cgi?id=4124#c2 
> 
> I am compiling 2.6.11-rc5 with preempt now. Then I will do the same on -mm2.
> Which "style" of preempt should I choose? 

Tried with vanilla-rc5 and preempt. Good news: now it suspends and resumes,
with the problem that while resuming I have a lot of "scheduling while
atomic" and the resume script segfaults (I do not know why, I didn't find
oops). Reloading the modules and restarting usb manually (i.e., doing
manually the rest of the script) make it works ok. Sort of, because
battery module did not see my battery the first time, only the second time I
load it.) After that, it works ok (it is compiling -mm2 now). 

On the other end, acpi keys works well, but now doing "acpi -V & acpi -V &
acpi -V" causes just one of them give the correct battery value, the others
are very fast but answers with "0%". 

All info (after boot, after resume, after having manually restarted battery
etc and usb) in:

http://www.dea.icai.upco.es/romano/linux/br/config-2.6.12-rc5-preempt-afterboot/laptop-config.html
http://www.dea.icai.upco.es/romano/linux/br/config-2.6.12-rc5-preempt-afterresume/laptop-config.html
http://www.dea.icai.upco.es/romano/linux/br/config-2.6.12-rc5-preempt-afterresume-and-modprobe/laptop-config.html

> PD: I have not applied the patch suggested there, because it causes the
> problem that two concurrent "read" of the battery fails (I mean: in vanilla
> 2.6.11-rc5 doing "acpi -V & acpi -V" give two times the same value, but with
> the patch
> http://www.dea.icai.upco.es/romano/linux/vaio-conf/patch-no3851.id4516 it
> gives a correct ouptput and the second one, running much faster, give 0% for
> the battery charge. 

Well. the excat same thing occurs (as I said above) without the patch and
with preempt. 

Will report -mm2 behaviour later. 

Hope this helps,

                  Romano
                  
-- 
Romano Giannetti             -  Univ. Pontificia Comillas (Madrid, Spain)
Electronic Engineer - phone +34 915 422 800 ext 2416  fax +34 915 596 569


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
