From: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Subject: Re: ACPI problems, Dell XPS 15z laptop
Date: Wed, 4 Jan 2012 17:19:06 -0700
Message-ID: <CAErSpo7s6NzmVoF+UfV37rXbby+P3QvzxGD=rLKCHjPAhvFx5Q@mail.gmail.com>
References: <4EF79074.90605@opensuse.org> <4EF7BDBC.9000406@opensuse.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <opensuse-kernel+bounces-3350-glsk-opensuse-kernel=m.gmane.org-stAJ6ESoqRxg9hUCZPvPmw@public.gmane.org>
List-Post: <mailto:opensuse-kernel-stAJ6ESoqRxg9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:opensuse-kernel+help-stAJ6ESoqRxg9hUCZPvPmw@public.gmane.org>
List-Subscribe: <mailto:opensuse-kernel+subscribe-stAJ6ESoqRxg9hUCZPvPmw@public.gmane.org>
List-Unsubscribe: <mailto:opensuse-kernel+unsubscribe-stAJ6ESoqRxg9hUCZPvPmw@public.gmane.org>
List-Owner: <mailto:opensuse-kernel+owner-stAJ6ESoqRxg9hUCZPvPmw@public.gmane.org>
List-Archive: <http://lists.opensuse.org/opensuse-kernel/>
In-Reply-To: <4EF7BDBC.9000406-stAJ6ESoqRxg9hUCZPvPmw@public.gmane.org>
To: =?ISO-8859-1?Q?Cristian_Rodr=EDguez?= <crrodriguez-stAJ6ESoqRxg9hUCZPvPmw@public.gmane.org>
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, opensuse-kernel-stAJ6ESoqRxg9hUCZPvPmw@public.gmane.org, Thomas Renninger <trenn-l3A5Bk7waGM@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Sun, Dec 25, 2011 at 5:20 PM, Cristian Rodr=EDguez
<crrodriguez-stAJ6ESoqRxg9hUCZPvPmw@public.gmane.org> wrote:

> Heh, today I tested a crazy theory I had about this problem, turned out t=
o
> be somewhat accurate.. it is not that the machine that hangs always, but =
it
> deceivingly "appears" to hang as I cannot get past the cryptsetup passwor=
d
> prompt.. it is the keyboard controller that becomes non responsive, that =
's
> it either before the "prompt" (where it hangs) or right after showing it.
> (in that scenario the USB port works, as plugin and removing a device sho=
ws
> the relevant events in the console)
>
> It is random, let's say, the USB port works twice every three boots.

If it's just USB or keyboard that's non-responsive, you may be able to
ssh into the box and collect a dmesg log.  Oh, but I suppose ssh is
not going to work if you're stuck at cryptsetup.  Netconsole might
work, if your kernel supports it.  Or maybe a video of a text-mode
boot?

It might be instructive to compare the log with no options with a log
using one of the options you found that seems to help.

Bjorn
