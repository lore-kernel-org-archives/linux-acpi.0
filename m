From: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Subject: Re: HP/Compaq NC6120 ACPI problems
Date: Mon, 21 Mar 2005 12:33:31 +0000
Message-ID: <1111408412.8136.233.camel@tyrosine>
References: <20050317200052.686d683f.andrej.prsa@guest.arnes.si>
	 <1111088904.11380.36.camel@eeyore>
	 <20050317215635.1c788c09.andrej.prsa@guest.arnes.si>
	 <1111104319.8136.182.camel@tyrosine>
	 <20050318192300.629e2148.andrej.prsa@guest.arnes.si>
	 <1111202374.8136.210.camel@tyrosine> <1111362416.8136.225.camel@tyrosine>
	 <20050321114014.38a548d4.andrej.prsa@guest.arnes.si>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <20050321114014.38a548d4.andrej.prsa-zs/Xt9NzJtxxh+DGd0HQrg@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, 2005-03-21 at 11:40 +0100, Andrej Prsa wrote:

> I see; please let me know when you get any additional information and of
> course if there's anything I can do to help! If it's not too much
> trouble, could you (or anyone else of course) please explain what
> exactly does this setpci do?

The setpci sets a register that allows the GPE to fire again. The BIOS
ought to be doing it itself - I've reported it to HP.

> Intriguingly, I recompiled the kernel with ACPI support built in (in
> contrast to having a modular ACPI support) and this time kacpid
> doesn't overload the processor and the fan is working!

Ah. That /may/ fit with my observations from suspend to disk - the
hardware seems unhappy if Linux and the hardware disagree about the fan
state. My suspicion is that if there's a thermal trip event between
Linux switching the hardware to ACPI mode and the fan module being
loaded, you'll get the "mad kacpid" behaviour. I'd strongly recommend
having the fan module built in - there's the risk of hardware damage
otherwise.

> > Warning - there'll be huge amounts of it. Really huge amounts. The
> > stuff we're interested in is whatever appears after kacpid has begun
> > taking up all the processor time.
> 
> Please find the messages.gz file at (3.1MB compressed size!):
> 
> 	http://www.fiz.uni-lj.si/~prsa/messages.gz
> 
> (sorry for the enormous size (~50MB uncompressed), but I didn't want to
> cut out anything relevant!) The start of the messages file is the start
> of kacpid going crazy.

Great, thanks! I'll take a look at this later on. When I traced it on
the 6220, I found that it seemed to be related to a thermal zone event,
which would fit with observations.

-- 
Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
