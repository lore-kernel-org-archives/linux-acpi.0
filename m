From: Dmitry Torokhov <dtor-xOqKmqBdiMhF6kxbq+BtvQ@public.gmane.org>
Subject: Re: [gpm] Untangling the sleep hotkey mess
Date: Wed, 30 Aug 2006 23:07:57 -0400
Message-ID: <200608302307.58511.dtor@insightbb.com>
References: <CFF307C98FEABE47A452B27C06B85BB601614F5A@hdsmsx411.amr.corp.intel.com>
	<200608302253.43784.dtor@insightbb.com>
	<200608302303.38458.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <gnome-power-manager-list-bounces-rDKQcyrBJuzYtjvyW6yDsg@public.gmane.org>
In-Reply-To: <200608302303.38458.len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://mail.gnome.org/mailman/listinfo/gnome-power-manager-list>,
	<mailto:gnome-power-manager-list-request-rDKQcyrBJuzYtjvyW6yDsg@public.gmane.org?subject=unsubscribe>
List-Archive: </archives/gnome-power-manager-list>
List-Post: <mailto:gnome-power-manager-list-rDKQcyrBJuzYtjvyW6yDsg@public.gmane.org>
List-Help: <mailto:gnome-power-manager-list-request-rDKQcyrBJuzYtjvyW6yDsg@public.gmane.org?subject=help>
List-Subscribe: <http://mail.gnome.org/mailman/listinfo/gnome-power-manager-list>,
	<mailto:gnome-power-manager-list-request-rDKQcyrBJuzYtjvyW6yDsg@public.gmane.org?subject=subscribe>
Sender: gnome-power-manager-list-bounces-rDKQcyrBJuzYtjvyW6yDsg@public.gmane.org
Errors-To: gnome-power-manager-list-bounces-rDKQcyrBJuzYtjvyW6yDsg@public.gmane.org
To: Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: desktop_portables-qjLDD68F18O7TbgM5vRIOg@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gnome-power-manager-list-rDKQcyrBJuzYtjvyW6yDsg@public.gmane.org, hal-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Wednesday 30 August 2006 23:03, Len Brown wrote:
> On Wednesday 30 August 2006 22:53, Dmitry Torokhov wrote:
> 
> > So... do you want me to make it work with !CONFIG_INPUT or shoudl I just
> > add a dependency on INPUT in Kconfig for button driver?
> 
> If virtually everybody uses INPUT, then I'm fine with the ACPI button driver simply depending
> on CONFIG_INPUT.
> 
> If nobody uses ACPI on a system without INPUT, then I don't see why we should
> muck up the code to suport a case that nobody will test or use.
> 

INPUT is not used on s390 but I suppose that's ok ;) You need to work
really hard to disable input (embedded, no VTs or anything, etc).

-- 
Dmitry
