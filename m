From: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: Smart Battery System driver
Date: Mon, 17 Jan 2005 14:20:23 +0100
Message-ID: <20050117132023.GT19199@poupinou.org>
References: <41E81C2C.8010809@bartol.udel.edu> <1105747983.7368.3.camel@tyrosine>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1105747983.7368.3.camel@tyrosine>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Sat, Jan 15, 2005 at 12:13:03AM +0000, Matthew Garrett wrote:
> On Fri, 2005-01-14 at 14:23 -0500, Rich Townsend wrote:
> 
> > ...provides access to the SBS via a new /proc/acpi/sbs interface, and
> > also provides a "legacy" /proc/acpi/battery interface that current
> > battery-monitoring tools can access. This driver depends on Bruno's 
> > i2c-acpi-ec driver, which I have included with my source code since a 
> > couple of bug fixes were necessary.
> 
> One thing I've been meaning to ask - several Thinkpads have an
> interesting design issue, whereby reading certain smbus addresses can
> render the machine unbootable without a motherboard replacement. As a
> result, i2c-piix refuses to load on Thinkpads. Does something similar
> need to be done for i2c-acpi-ec, or does it only provide i2c access to
> devices connected to the embedded controller?
> 

The latter.  But its possible that devices connected may be
faulty.  I'm not aware of a thinkpad with such i2c access (though
its possible there is one than can be legacy).

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
