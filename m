From: "Yinghai Lu" <yinghai@kernel.org>
Subject: Re: [patch 2/2] PNP: don't check disabled PCI BARs for conflicts in quirk_system_pci_resources()
Date: Wed, 1 Oct 2008 09:21:23 -0700
Message-ID: <86802c440810010921v3681d5f2gf1726e4f5ed36cc4@mail.gmail.com>
References: <48E11EFA.8010402@keyaccess.nl>
	 <alpine.LFD.2.00.0809300741320.3389@nehalem.linux-foundation.org>
	 <48E24C6F.3030903@keyaccess.nl>
	 <alpine.LFD.2.00.0809300904530.3389@nehalem.linux-foundation.org>
	 <alpine.LFD.2.00.0809301001280.3389@nehalem.linux-foundation.org>
	 <alpine.LFD.2.00.0809301015210.4651@nehalem.linux-foundation.org>
	 <20080930193819.GA29860@elte.hu>
	 <alpine.LFD.2.00.0809301244290.3262@nehalem.linux-foundation.org>
	 <20081001061328.GD7348@colo.lackof.org>
	 <alpine.LFD.2.00.0810010800510.11040@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.231]:59086 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751817AbYJAQVZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Oct 2008 12:21:25 -0400
Received: by rv-out-0506.google.com with SMTP id k40so667628rvb.1
        for <linux-acpi@vger.kernel.org>; Wed, 01 Oct 2008 09:21:24 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.0810010800510.11040@nehalem.linux-foundation.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Grant Grundler <grundler@parisc-linux.org>, Ingo Molnar <mingo@elte.hu>, Arjan van de Ven <arjan@infradead.org>, Rene Herman <rene.herman@keyaccess.nl>, Bjorn Helgaas <bjorn.helgaas@hp.com>, Jesse Barnes <jbarnes@virtuousgeek.org>, Len Brown <lenb@kernel.org>, Frans Pop <elendil@planet.nl>, "Rafael J. Wysocki" <rjw@sisk.pl>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, Adam Belay <abelay@mit.edu>, Avuton Olrich <avuton@gmail.com>, Karl Bellve <karl.bellve@umassmed.edu>, Willem Riede <wriede@riede.org>, Matthew Hall <mhall@mhcomputing.net>, Sam Ravnborg <sam@ravnborg.org>

On Wed, Oct 1, 2008 at 8:14 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> and instead do
>
>        initcall(pci_init, "pci");
>        ..
>        initcall(pnp_init, "pnp");
>
> and then just list the levels for the linker scripts in one place. So that
> we wouldn't really have to worry about link ordering: if the link ordering
> is wrong, we just add a new initcall level and insert it in the right
> place, and then we can look at the ordering and see it explicitly in one
> place instead of looking at the makefiles and checking the order we add
> object files to the list in!

don't need to think linking order.
could reorder them in the run time.

struct init_call_st {
        int level;
        char *name;
        initcall_t call;
};

#define INIT_CALL(nameX, levelX, callX) \
                static struct init_call_st __init_call_##nameX __initdata = \
                {       .name = nameX,\
                        .level = levelX,\
                        .call = callX,\
                }; \
                static struct init_call_st *__init_call_ptr_##nameX __used \
                __attribute__((__section__(".init_call.init"))) = \
                        &__init_call_##nameX

in vmlinux.lds.h
#define INIT_CALL_INIT(align)
         \
        . = ALIGN((align));                                             \
        .init_call.init : AT(ADDR(.init_call.init) - LOAD_OFFSET) {     \
                VMLINUX_SYMBOL(__init_call_start) = .;                  \
                *(.init_call.init)                                      \
                VMLINUX_SYMBOL(__init_call_end) = .;                    \
        }

let arch vmlinux.lds.S to have
INIT_CALL_INIT(8)

and init/main.c

void __init do_init_calls(void)
{
        struct init_call_st **daa;
        char *ptr;

        /* sort it?, prescan... */
        for (daa = __init_call_start ; daa < __init_call_end; daa++) {
                struct init_call_st *da = *daa;

...
        }

        for (daa = __init_call_start ; daa < __init_call_end; daa++) {
                struct dyn_array *da = *daa;
                ...
                da->call();
}


YH
