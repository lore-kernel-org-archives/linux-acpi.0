From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Hibernate on Presario 2100
Date: Sat, 5 Feb 2005 20:39:44 +0100
Message-ID: <20050205193944.GA1547@elf.ucw.cz>
References: <4203BD43.1040302@triumf.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4203BD43.1040302-K9O0zq5Arhf3fQ9qLvQP4Q@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Zaher Salman <zaher-K9O0zq5Arhf3fQ9qLvQP4Q@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> I have a Presario 2197CA with mandrake 10.0 and kernel 2.6.10. I have 
> been trying to get hibernate to work on it. The way I do it is by going 
> from X to text mode (ctrl+alt+F1), and then typing
> 
> echo -n disk > /sys/power/state
> 
> There is no problem to get the laptop to wake up and get back to text 
> mode, but whenever I try to switch to X (ctrl+alt+F7), or if I go to 
> hibernate from X, the laptop hangs and I have to reboot it. When it 
> hangs a few things still work like the thouchpad so I can mover the 
> mouse and the function keys work. However, is seems that the keyboard 
> does not respond (like CapsLock, ctrl+alt+Backspace), and there is no 
> network. Any idea why this is happening?

Try running with vesafb and un-accelerated X server.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
